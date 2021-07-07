import 'package:do_it/screens/todo/TodoOnClickView/todo_viewscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ListViewTodo extends StatefulWidget {
  const ListViewTodo({Key? key}) : super(key: key);

  @override
  _ListViewTodoState createState() => _ListViewTodoState();
}

class _ListViewTodoState extends State<ListViewTodo> {
  final Stream<QuerySnapshot> _streamSnap = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("todo")
      .orderBy("isfav", descending: true)
      .snapshots();
  bool val = false;
  Color _color = Colors.white;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return StreamBuilder(
        stream: _streamSnap,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CupertinoActivityIndicator();
          }
          if (!snapshot.hasData) {
            return Text("Loading . . .");
          }

          if (snapshot.hasData) {
            if (snapshot.data!.docs.length == 0) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      "You don't have any Todo yet",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              );
            } else {
              return ListView(
                physics: BouncingScrollPhysics(),
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  if (data["isdone"]) {
                    _color = Colors.teal.withOpacity(.5);
                  } else if (!data["isdead"]) {
                    _color = Colors.white;
                  } else {
                    _color = Colors.red.withOpacity(.5);
                  }
                  return InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: screenWidth * .055,
                        left: screenWidth * .055,
                        bottom:
                            screenHeight * .033 > 25 ? screenHeight * .033 : 25,
                        top:
                            screenHeight * .033 > 25 ? screenHeight * .033 : 25,
                      ),
                      child: Container(
                        height: screenHeight * .144 > 110
                            ? screenHeight * .144
                            : 110,
                        width: screenWidth,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                            // color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.05),
                                blurRadius: 80,
                                spreadRadius: 1,
                                offset: Offset(0, 3),
                              ),
                            ]
                            //borderRadius: BorderRadius.circular(10),
                            ),
                        //color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: screenWidth * .0833,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 30,
                                    width: screenWidth * .014,
                                    color: Colors.white,
                                  ),
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: BoxConstraints(),
                                      onPressed: () {
                                        taskDone(data);
                                      },
                                      icon: data["isdone"]
                                          ? Icon(
                                              Icons.check_box,
                                              color:
                                                  Colors.teal.withOpacity(.7),
                                            )
                                          : Icon(
                                              Icons.check_box_outline_blank,
                                            )),
                                  Container(
                                    height: 30,
                                    width: screenWidth * .014,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: screenWidth * .0416),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TodoView(data)));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white10,
                                      border: Border.all(
                                          color: data["isdone"]
                                              ? Colors.white10
                                              : Colors.white,
                                          width: screenWidth * .00277),
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
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: screenWidth * .027,
                                        color: _color,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 40,
                                            width: screenWidth * .664,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: screenWidth *
                                                            .0221),
                                                    child: Container(
                                                      width: screenWidth * .277,
                                                      height: 40,
                                                      child: Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 8.0,
                                                                  top: 10),
                                                          child: data["isdead"]
                                                              ? Text(
                                                                  data[
                                                                      "deadline"],
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize: 9,
                                                                  ),
                                                                )
                                                              : Text(
                                                                  "No Deadline",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize: 9,
                                                                  ),
                                                                ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: screenWidth * .1108,
                                                  height: 40,
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      favChange(data);
                                                    },
                                                    icon: data["isfav"]
                                                        ? Icon(
                                                            Icons.push_pin,
                                                            size: 18,
                                                            color:
                                                                Colors.orange,
                                                          )
                                                        : Icon(
                                                            Icons
                                                                .push_pin_outlined,
                                                            size: 15,
                                                            color: Colors.grey,
                                                          ))
                                              ],
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: screenWidth * .0221),
                                              child: Container(
                                                width: screenWidth * .609,
                                                child: data["isdone"]
                                                    ? Text(
                                                        data["title"],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black
                                                              .withOpacity(.7),
                                                        ),
                                                      )
                                                    : Text(
                                                        data["title"],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black
                                                              .withOpacity(.7),
                                                        ),
                                                      ),
                                              )),
                                          Container(
                                            height: 40,
                                            width: screenWidth * .664,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    width: screenWidth * .1662,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .subdirectory_arrow_right_sharp,
                                                            size: 10,
                                                            color: Colors.grey,
                                                          ),
                                                          Text(
                                                            data["numsub"],
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(
                                                            width: screenWidth *
                                                                .01385,
                                                          ),
                                                          Icon(
                                                            Icons.comment,
                                                            size: 10,
                                                            color: Colors.grey,
                                                          ),
                                                          Text(
                                                            data["numcom"],
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: screenWidth * .1662,
                                                  ),
                                                  Container(
                                                    width: screenWidth * .2770,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: Padding(
                                                        padding: EdgeInsets.only(
                                                            right: screenWidth *
                                                                .02216),
                                                        child: IconButton(
                                                          icon: Icon(
                                                            Icons.delete,
                                                            size: 15,
                                                            color: Colors.grey,
                                                          ),
                                                          onPressed: () {
                                                            displayDialogue(
                                                                screenWidth,
                                                                data);
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }
          }
          return Text("No data found");
        });
  }

  Future<void> favChange(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("todo")
        .doc(data["id"])
        .update({
      "isfav": !data["isfav"],
    });
  }

  Future<void> taskDone(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("todo")
        .doc(data["id"])
        .update({
      "isdone": true,
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("stats")
        .doc("tododone")
        .get()
        .then((value) async {
      if (value.exists) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("stats")
            .doc("tododone")
            .update({
          "tododone": FieldValue.increment(1),
        });
      } else {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("stats")
            .doc("tododone")
            .set({"tododone": 1});
      }
    });
  }

  void displayDialogue(double screenWidth, Map<String, dynamic> data) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(
                "Do you want to delete this task?",
                style: TextStyle(
                    color: Colors.black.withOpacity(.8),
                    fontWeight: FontWeight.bold,
                    fontSize: 13),
              ),
              content: Text(data["title"]),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        height: 35,
                        width: screenWidth * .277,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              elevation: MaterialStateProperty.all(0),
                              side: MaterialStateProperty.all(BorderSide(
                                  width: 1, color: Colors.red.withOpacity(.5))),
                              overlayColor: MaterialStateProperty.all(
                                  Colors.redAccent.withOpacity(.5))),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        )),
                    Container(
                        height: 35,
                        width: screenWidth * .277,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.black.withOpacity(.7)),
                            overlayColor:
                                MaterialStateProperty.all(Colors.black),
                            //elevation: MaterialStateProperty.all(0),
                            //shape: MaterialStateProperty.all(),
                          ),
                          onPressed: () {
                            deleteTask(data);
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Delete",
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ],
                )
              ],
            ));
  }

  Future<void> deleteTask(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("todo")
        .doc(data["id"])
        .delete();
  }
}
