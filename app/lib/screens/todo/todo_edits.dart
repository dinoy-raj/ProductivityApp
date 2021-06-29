import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TodoEditing extends StatefulWidget {
  const TodoEditing({Key? key}) : super(key: key);

  @override
  _TodoEditingState createState() => _TodoEditingState();
}

class _TodoEditingState extends State<TodoEditing> {
  Future<void> updateData() async {
    Map<String, dynamic> data = {
      "body": _bodyController.text,
      "title": _titleController.text
    };
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("todo");
    await collectionReference.add(data);
  }

  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Tooltip(
              message: "Exit Without Saving",
              child: Icon(
                Icons.cancel,
                color: Colors.black,
              ),
            )),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Add Todo",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            Container(
              width: screenWidth,
              height: screenHeight * .2,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 15, top: 8, bottom: 8),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: TextFormField(
                      validator: (String? value) {
                        return value == null ? "Field Cannot Be Empty" : null;
                      },
                      controller: _titleController,
                      maxLines: 5,
                      //autocorrect: true,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      decoration: InputDecoration(
                        hintText: "Title",
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
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
                      left: 25, right: 15, top: 8, bottom: 8),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: TextField(
                        maxLines: 10,
                        controller: _bodyController,
                        //autocorrect: true,
                        style: TextStyle(fontSize: 15),
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
              height: screenHeight * .15,
            ),
            Container(
              height: 40,
              width: screenWidth * .4,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  onPressed: () {
                    if (_titleController.text != "" &&
                        _bodyController.text != "") {
                      updateData();
                      Navigator.pop(context);
                    } else {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Title and Content should not be empty!",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  OutlineButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel"),
                                  )
                                ],
                              ),
                            );
                          });
                    }
                  },
                  child: Text(
                    "Add Todo",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )),
            ),
            SizedBox(
              height: screenHeight * .3,
            )
          ],
        ),
      ),
    );
  }
}
