import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            return Text("Has Not Have Any Notes");
          }

          if (snapshot.hasData) {
            if (snapshot.data!.docs.length == 0) {
              return Column(
                children: [
                  Text(
                    "You Don't Have Any Notes Yet",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ],
              );
            } else {

              return ListView(

                children:  snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
                  return InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,

                    onTap: () {

                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0,left: 20,bottom: 20,top: 20),
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
                            Column(
                              children: [
                                Text(data["title"]),
                                Text(data["isdone"].toString()),
                                Text(data["isdead"].toString()),
                                Text(data["deadline"]),
                              ],
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
}
