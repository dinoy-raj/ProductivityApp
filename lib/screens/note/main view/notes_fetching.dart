import 'dart:math';
import 'package:do_it/screens/note/note%20view/note_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class GridDataView extends StatefulWidget {
  const GridDataView({Key? key}) : super(key: key);

  @override
  _GridDataViewState createState() => _GridDataViewState();
}

class _GridDataViewState extends State<GridDataView> {
  bool isclic = false;
  // User? _user = FirebaseAuth.instance.currentUser;
  final Stream<QuerySnapshot> _streamSnap = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("notes")
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
                Padding(
                  padding: const EdgeInsets.only(top:20.0),
                  child: Text(
                    "You don't have any notes yet",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            );
          } else {
            return GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              physics: BouncingScrollPhysics(),
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                return InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,

                    onTap: () {
                      isclic = true;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NoteView(data)));
                    },
                    child: Container(
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
                      padding: EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Container(
                                height: 5,
                                width: 15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  shape: BoxShape.rectangle,
                                  color: RandomColorModel().getColor(),
                                ),
                              ),
                            ),
                            Container(
                                child: Text(
                              data["title"],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )),
                            Padding(
                              padding: const EdgeInsets.only(top: 13),
                              child: Container(
                                  child: Text(
                                data["body"],
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 10),
                              )),
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

        return Text("Has Not Have Any Notes");
      },
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
