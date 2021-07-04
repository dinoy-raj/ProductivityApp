import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
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
              Container(
                width: screenWidth,
                height: screenHeight * .4,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 45, right: 15, top: 8, bottom: 8),
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
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
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
                      ]
                    //borderRadius: BorderRadius.circular(10),
                  ),
                  width: screenWidth,
                  height: screenHeight * .8,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 15, top: 15, bottom: 8),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Text(data["body"],textAlign: TextAlign.start,)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * .15,
              ),
              Container(
                height: 40,
                width: screenWidth ,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.black),
                        ),
                        onPressed: () {
                          // Future<void> deleteUser() {
                          //   return users.doc(data)
                          //       .delete()
                          //       .then((value) => print("User Deleted"))
                          //       .catchError((error) => print("Failed to delete user: $error"));
                          // }
                        },
                        child: Text(
                          "Delete",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        )),
                    SizedBox(width: 100,),
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.black),

                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * .3,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RandomColorModel {
  Random random = Random();
  Color getColor() {
    return Color.fromARGB(255, random.nextInt(256),
        random.nextInt(256), random.nextInt(256));
  }
}
