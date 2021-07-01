import 'dart:math';

import 'package:app/screens/note/note%20view/note_view_update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NoteView extends StatefulWidget {
  Map<String, dynamic> data;
  NoteView(this.data);

  @override
  _NoteViewState createState() => _NoteViewState(data);
}

class _NoteViewState extends State<NoteView> {
  Map<String, dynamic> data;
  _NoteViewState(this.data);
  final _formKey = GlobalKey<FormState>();
  bool _isEditable = false;

  deleteData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("notes")
        .doc(data["id"])
        .delete();
  }

  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    print(screenHeight);
    print(screenWidth);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white10,
          leading: IconButton(
              splashRadius: 10,
              onPressed: () {
                setState(() {
                  _isEditable ? _isEditable = false : Navigator.pop(context);
                });
              },
              icon: Tooltip(
                message: "Exit Without Saving",
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.black,
                  size: 23,
                ),
              )),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: screenWidth * .055),
                    child: Container(
                      height: 10,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.rectangle,
                        color: RandomColorModel().getColor(),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: screenWidth,
                  height: screenWidth * .06 * 6,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * .07,
                        right: screenWidth * .0416,
                        top: screenHeight * 0.0105,
                        bottom: screenHeight * 0.0105),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Text(
                            data["title"],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: screenHeight * .0263,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * .07, right: screenWidth * .07),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.1),
                            blurRadius: 100,
                            spreadRadius: 2,
                            offset: Offset(0, 3),
                          ),
                        ]),
                    width: screenWidth,
                    height: screenWidth * .0416 * 20,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * .07,
                          right: screenWidth * .0416,
                          top: screenHeight * .03,
                          bottom: screenHeight * .0105),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Text(
                            data["body"],
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * .1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        height: screenHeight * 0.0526 < 40
                            ? 40
                            : screenHeight * 0.0526,
                        width: screenWidth * .4,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              elevation: MaterialStateProperty.all(0),
                              side: MaterialStateProperty.all(
                                  BorderSide(width: 1, color: Colors.red)),
                              overlayColor: MaterialStateProperty.all(
                                  Colors.redAccent.withOpacity(.5))),
                          onPressed: () {
                            setState(() async {
                              await deleteData();
                              Navigator.pop(context);
                            });
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Delete",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        )),
                    Container(
                        height: screenHeight * 0.0526 < 40
                            ? 40
                            : screenHeight * 0.0526,
                        width: screenWidth * .4,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                            //elevation: MaterialStateProperty.all(0),
                            //shape: MaterialStateProperty.all(),
                          ),
                          onPressed: () {
                            setState(() {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>NoteUpdating(data)));
                            });
                          },
                          child: Text(
                            "Edit Note",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: screenHeight * .1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RandomColorModel {
  Random random = Random();
  Color getColor() {
    return Color.fromARGB(
        255, random.nextInt(256), random.nextInt(256), random.nextInt(256));
  }
}