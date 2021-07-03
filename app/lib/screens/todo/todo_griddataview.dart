import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

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
      .snapshots();
  bool val = false;
  @override
  Widget build(BuildContext context) {
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
            return Text("Has Not Have Any Todo");
          }

          if (snapshot.hasData) {
            if (snapshot.data!.docs.length == 0) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      "You Don't Have Any Todo Yet",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ),
                ],
              );
            } else {
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  print(data);
                  return InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 20.0, left: 20, bottom: 20, top: 20),
                      child: Container(
                        height: 100,
                        width: 500,
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
                          children: [
                            Container(
                              width: 30,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 30,
                                    width: 5,
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

                                                )
                                              : Icon(
                                                  Icons.check_box_outline_blank,
                                          )
                                      ),



                                  Container(
                                    height: 30,
                                    width: 5,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white10,
                                    border: Border.all(
                                        color: Colors.white, width: 1),
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
                                      width: 10,
                                      color: Colors.white,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 240,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    favChange(data);
                                                  },
                                                  icon: data["isfav"]
                                                      ? Icon(
                                                          Icons.push_pin,
                                                          size: 18,
                                                          color: Colors.orange,
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
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Container(
                                                width: 220,
                                                child: Text(
                                                  data["title"],
                                                  style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black
                                                        .withOpacity(.7),
                                                  ),
                                                ))),
                                        Container(
                                          height: 40,
                                          width: 240,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Container(
                                                  width: 60,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0),
                                                    child: Row(
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
                                                          width: 5,
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
                                                  width: 60,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: Container(
                                                    width: 100,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 8.0),
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
                                                )
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
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }
          }
          return Text("No Data Found");
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
  }
}
