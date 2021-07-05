import 'package:app/screens/splashscreen/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class TodoSubTask extends StatefulWidget {
  double screenWidth;
  Map<String, dynamic> data;
  TodoSubTask(this.screenWidth, this.data);

  @override
  _TodoSubTaskState createState() => _TodoSubTaskState(data);
}

class _TodoSubTaskState extends State<TodoSubTask> {
  _TodoSubTaskState(this.data);
  Map<String, dynamic> data;
  String id = "";
  initState() {
    super.initState();
    id = data["id"];
  }

  TextEditingController _subtaskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _streamSnap = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("todo")
        .doc(id)
        .collection("subtask")
        .snapshots();
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 50,
            width: widget.screenWidth,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                color: Colors.white10,
                border: Border.all(color: Colors.white, width: 1),
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
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: widget.screenWidth * .4,
                    child: TextFormField(
                      maxLines: 1,
                      controller: _subtaskController,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black.withOpacity(.6),
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        hintText: "Add Tasks",
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    width: widget.screenWidth * .15,
                    child: ElevatedButton(
                      child: Text(
                        "add",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          overlayColor: MaterialStateProperty.all(
                              Colors.white.withOpacity(.5))),
                      onPressed: () {
                        addSubtask(data);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 20,
          ),
          Container(
            height: 240,
            child: StreamBuilder(
                stream: _streamSnap,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error In Fetching Data");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CupertinoActivityIndicator();
                  }
                  if (!snapshot.hasData) {
                    return Text("You Don't Have Any SubTasks");
                  }
                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.length == 0) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(
                              "You Don't Have Any SubTasks Yet",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return ListView(
                          physics: BouncingScrollPhysics(),
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> datan =
                                document.data() as Map<String, dynamic>;
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white10,
                                  border:
                                      Border.all(color: Colors.white, width: 1),

                                  //borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                        height: 20,
                                        width: 20,
                                        color: Colors.white,
                                        child: Center(
                                            child:
                                                Text(datan["no"].toString()))),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Container(
                                        width: 200,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Text(
                                        datan["subtask"],
                                        style: TextStyle(
                                              color: Colors.black.withOpacity(.5),
                                              fontWeight: FontWeight.bold),
                                      ),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList());
                    }
                  }
                  return Text("error");
                }),
          ),
        ],
      ),
    );
  }
  addSubtask(Map<String, dynamic> datan)


  async {
    int num = data["numsub"];
    num = num+1;
    if(_subtaskController.text!="") {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("todo")
          .doc(id)
          .collection("subtask")
          .doc(id)
          .set({
        "subtask": _subtaskController.text,
        "no": num,
      });
    }
  }
}
