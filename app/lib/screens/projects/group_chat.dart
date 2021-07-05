import 'dart:async';

import 'package:app/screens/projects/projectscreen.dart';
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

  getMessages() {
    _streamSubscription = FirebaseFirestore.instance
        .collection("users")
        .doc(project.owner!['uid'])
        .collection("owned_projects")
        .doc(project.id)
        .collection("chats")
        .snapshots()
        .listen((event) {
      event.docs.forEach((date) {
        _groupChats = date.get('chats');
      });
      setState(() {
        _loading = false;
      });
    });
  }

  sendMessage() async {
    var _now = DateTime.now();

    _groupChats.insert(0, {
      'date': DateFormat('dd-MM-yyyy').format(_now),
      'time': DateFormat('hh:mm a').format(_now),
      'message': _textController.text.trim(),
      'image': FirebaseAuth.instance.currentUser!.photoURL,
    });

    _textController.clear();

    await FirebaseFirestore.instance
        .collection("users")
        .doc(project.owner!['uid'])
        .collection("owned_projects")
        .doc(project.id)
        .collection("chats")
        .doc("group_chat")
        .set({'chats': _groupChats});
  }

  @override
  void initState() {
    super.initState();
    getMessages();
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
        backgroundColor: Colors.grey[300],
        iconTheme: IconThemeData(
          color: Colors.grey[800],
        ),
        centerTitle: true,
        title: Text(project.title!,
            style: GoogleFonts.poppins(
              fontSize: 24,
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
                                  _groupChats[index]['date'] ==
                                          DateFormat('dd-MM-yyyy')
                                              .format(DateTime.now())
                                      ? "Today"
                                      : DateTime.now()
                                                  .difference(
                                                      DateFormat('dd-MM-yyyy')
                                                          .parse(
                                                              _groupChats[index]
                                                                  ['date']))
                                                  .inHours <=
                                              48
                                          ? "Yesterday"
                                          : _groupChats[index]['date'],
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
                                                  height: 50,
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
                                            Text(
                                              _groupChats[index]['message'],
                                              textAlign: _groupChats[index]
                                                          ['image'] ==
                                                      FirebaseAuth.instance
                                                          .currentUser!.photoURL
                                                  ? TextAlign.end
                                                  : TextAlign.start,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              _groupChats[index]['time'],
                                              style: TextStyle(
                                                fontSize: 10,
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
                                                height: 50,
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
