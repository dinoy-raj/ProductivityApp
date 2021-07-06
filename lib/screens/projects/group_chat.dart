import 'dart:async';
import 'package:do_it/screens/projects/projectscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class GroupChat extends StatefulWidget {
  GroupChat(this.project);

  final Project project;
  @override
  State<StatefulWidget> createState() {
    return GroupChatState(project);
  }
}

class GroupChatState extends State<GroupChat> {
  GroupChatState(this.project);

  final Project project;
  final _textController = TextEditingController();
  StreamSubscription? _streamSubscription;
  List _groupChats = [];
  bool _loading = true;

  getColour(image) {
    int index = 0;
    for (var element in project.collab!) {
      if (element['image'] == image) break;
      index++;
    }
    return Colors.accents[index % 16];
  }

  getGroupChats() {
    _streamSubscription = FirebaseFirestore.instance
        .collection("users")
        .doc(project.owner!['uid'])
        .collection("owned_projects")
        .doc(project.id)
        .collection("chats")
        .doc("group_chat")
        .snapshots()
        .listen((event) {
      _groupChats.clear();
      event.data()?.forEach((key, value) {
        value['datetime'] = DateTime.parse(key);
        _groupChats.add(value);
      });
      _groupChats.sort((a, b) => b['datetime'].compareTo(a['datetime']));
      setState(() {
        _loading = false;
      });
    });
  }

  sendMessage() async {
    var _now = DateTime.now();

    Map<String, dynamic> data = {
      _now.toString(): {
        'message': _textController.text.trim(),
        'image': FirebaseAuth.instance.currentUser!.photoURL,
      }
    };

    _textController.clear();

    await FirebaseFirestore.instance
        .collection("users")
        .doc(project.owner!['uid'])
        .collection("owned_projects")
        .doc(project.id)
        .collection("chats")
        .doc("group_chat")
        .set(data, SetOptions(merge: true));

    if (FirebaseAuth.instance.currentUser!.uid != project.owner!['uid'])
      await FirebaseFirestore.instance
          .collection("users")
          .doc(project.owner!['uid'])
          .collection("alerts")
          .doc(project.id)
          .update({
        "unreadGroupChatCount": FieldValue.increment(1),
      });

    project.collab?.forEach((element) async {
      if (FirebaseAuth.instance.currentUser!.uid != element['uid'])
        await FirebaseFirestore.instance
            .collection("users")
            .doc(element['uid'])
            .collection("alerts")
            .doc(project.id)
            .update({
          "unreadGroupChatCount": FieldValue.increment(1),
        });
    });
  }

  markAsRead() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("alerts")
          ..doc(project.id).update({
            "unreadGroupChatCount": 0,
          });
  }

  @override
  void initState() {
    super.initState();
    getGroupChats();
    markAsRead();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool dateSet;

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.grey[800],
        ),
        centerTitle: true,
        title: Text(project.title!,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            )),
      ),
      body: _loading
          ? Center(
              child: CupertinoActivityIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      reverse: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: _groupChats.length,
                      itemBuilder: (context, index) {
                        DateTime dateTime = _groupChats[index]['datetime'];
                        final now = DateTime.now();
                        final today = DateTime(now.year, now.month, now.day);
                        final yesterday =
                            DateTime(now.year, now.month, now.day - 1);
                        final date = DateTime(
                            dateTime.year, dateTime.month, dateTime.day);

                        if (index == _groupChats.length - 1 ||
                            _groupChats[index]['date'] !=
                                _groupChats[index + 1]['date'])
                          dateSet = true;
                        else
                          dateSet = false;

                        return Column(
                          children: [
                            if (dateSet)
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  date == yesterday
                                      ? "Yesterday"
                                      : date == today
                                          ? "Today"
                                          : DateFormat('dd-MM-yyyy')
                                              .format(dateTime),
                                ),
                              ),
                            Padding(
                              padding: _groupChats[index]['image'] ==
                                      FirebaseAuth
                                          .instance.currentUser!.photoURL
                                  ? const EdgeInsets.only(
                                      right: 10, left: 50, top: 5, bottom: 5)
                                  : const EdgeInsets.only(
                                      right: 50, left: 10, top: 5, bottom: 5),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      if (_groupChats[index]['image'] !=
                                          FirebaseAuth
                                              .instance.currentUser!.photoURL)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              child: Container(
                                                  height: 40,
                                                  child: Image.network(
                                                      _groupChats[index]
                                                          ['image']))),
                                        ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: _groupChats[index]
                                                      ['image'] ==
                                                  FirebaseAuth.instance
                                                      .currentUser!.photoURL
                                              ? CrossAxisAlignment.end
                                              : CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: _groupChats[index]
                                                              ['image'] ==
                                                          FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .photoURL
                                                      ? Colors.grey
                                                      : getColour(
                                                          _groupChats[index]
                                                              ['image']),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              padding: EdgeInsets.all(10),
                                              child: Text(
                                                _groupChats[index]['message'],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                textAlign: _groupChats[index]
                                                            ['image'] ==
                                                        FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .photoURL
                                                    ? TextAlign.end
                                                    : TextAlign.start,
                                                overflow: TextOverflow.clip,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5, right: 5, top: 5),
                                              child: Text(
                                                DateFormat('hh:mm a').format(
                                                    _groupChats[index]
                                                        ['datetime']),
                                                style: TextStyle(
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (_groupChats[index]['image'] ==
                                          FirebaseAuth
                                              .instance.currentUser!.photoURL)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: Container(
                                                height: 40,
                                                child: Image.network(
                                                    _groupChats[index]
                                                        ['image'])),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          textCapitalization: TextCapitalization.sentences,
                          controller: _textController,
                          onChanged: (text) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            hintText: "Enter your message...",
                            contentPadding: EdgeInsets.all(10),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey[800]!,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey[800]!,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _textController.text.trim().isNotEmpty
                          ? sendMessage
                          : null,
                      color: Colors.grey[800],
                      icon: Icon(
                        Icons.send_sharp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
