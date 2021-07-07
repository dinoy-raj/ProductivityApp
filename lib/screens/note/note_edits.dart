import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NoteEditing extends StatefulWidget {
  const NoteEditing({Key? key}) : super(key: key);

  @override
  _NoteEditingState createState() => _NoteEditingState();
}

class _NoteEditingState extends State<NoteEditing> {
  final _formKey = GlobalKey<FormState>();
  addData() async {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random.secure();

    String id = String.fromCharCodes(Iterable.generate(
        20, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("notes")
        .doc(id)
        .set({
      "noteid": id,
      "body": _bodyController.text,
      "title": _titleController.text
    });

    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("stats")
        .doc("notesno")
        .get()
        .then((value) async {
      if (value.exists) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("stats")
            .doc("notesno")
            .update({
          "notesno": FieldValue.increment(1),
        });
      } else {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("stats")
            .doc("notesno")
            .set({"notesno": 1});
      }
    });
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
                Navigator.pop(context);
              },
              icon: Tooltip(
                message: "Exit Without Saving",
                child: Icon(
                  Icons.cancel,
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
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * .07, bottom: screenWidth * .055),
                    child: Text(
                      "Add Note",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                ),
                Container(
                  width: screenWidth,
                  height: 130,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * .07,
                        right: screenWidth * .0416,
                        top: screenHeight * 0.0105,
                        bottom: screenHeight * 0.0105),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? value) {
                            return value == null || value.trim().isEmpty
                                ? "Title Should Not Be Empty"
                                : null;
                          },
                          controller: _titleController,
                          maxLines: 3,
                          autofocus: true,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          decoration: InputDecoration(
                            hintText: "Title",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2),
                            ),
                            disabledBorder: InputBorder.none,
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
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
                    height: 300,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * .07,
                          right: screenWidth * .0416,
                          top: screenHeight * .0105,
                          bottom: screenHeight * .0105),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: TextFormField(
                            maxLines: 10,
                            controller: _bodyController,
                            style: TextStyle(fontSize: 17, color: Colors.black),
                            decoration: InputDecoration(
                              hintText: "Content",
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
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
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
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
                            if (_formKey.currentState!.validate()) {
                              addData();
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            "Add Note",
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
