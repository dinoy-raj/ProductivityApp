import 'dart:async';

import 'package:app/screens/projects/projectscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  List _chats = [];
  List _chatList = [];
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
        _chats = date.get('chats');
        _chatList.add(_chats);
      });
      setState(() {
        _loading = false;
      });
    });
  }

  sendMessage() async {
    var _now = DateTime.now();

    _chats.add({
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
        .doc(DateFormat('dd-MM-yyyy').format(_now))
        .set({'chats': _chats});
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
    //int count = 0;
    //_chatList.fo
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.grey[800],
        ),
      ),
      body: _loading
          ? Center(
              child: CupertinoActivityIndicator(),
            )
          : Column(
              children: [
                //ListView.builder(
                //  itemCount: ,
                //itemBuilder: (context, index) {

                // }),
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
