import 'package:app/screens/todo/TodoOnClickView/todo_viewscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ListCatalog extends StatefulWidget {
  const ListCatalog({Key? key}) : super(key: key);

  @override
  _ListCatalogState createState() => _ListCatalogState();
}

class _ListCatalogState extends State<ListCatalog> {
  final Stream<QuerySnapshot> _streamSnap = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("todo")
      .where("isfav", isEqualTo: true)
      .snapshots();
  bool val = false;
  Color _color = Colors.white;
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
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                    child: Text(
                      "You Don't Have Any Todo Pinned Yet",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    child: Lottie.network(
                        "https://assets7.lottiefiles.com/packages/lf20_f03c4dci.json"),
                  ),
                ],
              );
            } else {
              return ListView(
                scrollDirection: Axis.horizontal,
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
                      padding: const EdgeInsets.only(
                          right: 20.0, left: 20, bottom: 20, top: 20),
                      child: Container(
                        height: 100,
                        width: 270,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
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
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white10,
                                  border: Border.all(
                                      color: data["isdone"]
                                          ? Colors.white10
                                          : Colors.white,
                                      width: 1),

                                  //borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 10,
                                      color: _color,
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
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Container(
                                                  width: 100,
                                                  height: 40,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 8.0,
                                                              top: 10),
                                                      child: data["isdead"]
                                                          ? Text(
                                                              data["deadline"],
                                                              style: TextStyle(
                                                                fontSize: 9,
                                                              ),
                                                            )
                                                          : Text(
                                                              "No Deadline",
                                                              style: TextStyle(
                                                                fontSize: 9,
                                                              ),
                                                            ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 40,
                                                height: 40,
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    favChange(data);
                                                  },
                                                  icon: Icon(
                                                    Icons.push_pin,
                                                    size: 18,
                                                    color: Colors.orange,
                                                  ))
                                            ],
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Container(
                                              width: 220,
                                              child: data["isdone"]
                                                  ? Text(
                                                      data["title"],
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                          width: 240,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
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
                                                Container(
                                                  width: 100,
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
