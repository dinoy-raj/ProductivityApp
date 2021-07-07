import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:windows/screens/projects/projectscreen.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  String tt = "0";
  String ct = "0";
  String tn = "0";
  String cp = "0";
  String task = "0";

  addData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("stats")
        .doc("notesno")
        .get()
        .then((value) async {
      if (value.exists) {
        setState(() {
          tn = value.get("notesno").toString();
        });
      }
    });

    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("stats")
        .doc("todono")
        .get()
        .then((value) async {
      if (value.exists) {
        setState(() {
          tt = value.get("todono").toString();
        });
      }
    });

    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("stats")
        .doc("tododone")
        .get()
        .then((value) async {
      if (value.exists) {
        setState(() {
          ct = value.get("tododone").toString();
        });
      }
    });
    await Project().getCompletedProjectCount().then((value) {
      setState(() {
        cp = value.toString();
      });
    });
    await Project().getCompletedTaskCount().then((value) {
      setState(() {
        task = value.toString();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    addData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    print(ct);
    print(tt);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        leading: IconButton(
            splashRadius: .5,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Tooltip(
              message: "Exit Stats",
              child: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.black,
              ),
            )),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: screenHeight * .3,
                  width: screenWidth,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FeatherIcons.checkCircle,
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Do It",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: screenHeight * .3,
                        width: 1,
                        color: Colors.grey,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 2,
                            width: 20,
                            color: Colors.white,
                          ),
                          Text(
                            "Statistics",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              letterSpacing: 2,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Complete Analysis of your Activities",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 8,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
              SizedBox(
                height: screenHeight * .1,
              ),
              Row(
                children: [
                  Container(
                    height: 100,
                    width: screenWidth * .3,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.withOpacity(.4)),
                      color: Colors.white,
                      //borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Todo",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * .02,
                  ),
                  Container(
                    height: 100,
                    width: screenWidth * .59,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      //borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: screenWidth * .25,
                          height: 80,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 30,
                                width: screenWidth * .2,
                                child: Center(
                                    child: Text(
                                  "Total",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(.7)),
                                )),
                              ),
                              Container(
                                height: 50,
                                child: Center(
                                    child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Text(
                                    tt,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black.withOpacity(.7)),
                                  ),
                                )),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: screenWidth * .25,
                          height: 80,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 30,
                                width: screenWidth * .2,
                                child: Center(
                                    child: Text(
                                  "Completed",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(.7)),
                                )),
                              ),
                              Container(
                                height: 50,
                                child: Center(
                                    child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Text(
                                    ct,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black.withOpacity(.7)),
                                  ),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * .03,
              ),
              Row(
                children: [
                  Container(
                    height: 100,
                    width: screenWidth * .3,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(.4)),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      //borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Projects",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * .02,
                  ),
                  Container(
                    height: 100,
                    width: screenWidth * .59,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      //borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: screenWidth * .25,
                          height: 80,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 30,
                                width: screenWidth * .2,
                                child: Center(
                                    child: Text(
                                  "Completed Projects",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(.7)),
                                )),
                              ),
                              Container(
                                height: 50,
                                child: Center(
                                    child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Text(
                                    cp,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black.withOpacity(.7)),
                                  ),
                                )),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: screenWidth * .25,
                          height: 80,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 30,
                                width: screenWidth * .2,
                                child: Center(
                                    child: Text(
                                  "Completed Tasks",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(.7)),
                                )),
                              ),
                              Container(
                                height: 50,
                                child: Center(
                                    child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Text(
                                    task,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black.withOpacity(.7)),
                                  ),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * .03,
              ),
              Row(
                children: [
                  Container(
                    height: 100,
                    width: screenWidth * .3,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(.4)),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      //borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Notes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * .02,
                  ),
                  Container(
                    height: 100,
                    width: screenWidth * .59,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      //borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: screenWidth * .45,
                          height: 80,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 30,
                                width: screenWidth * .2,
                                child: Center(
                                    child: Text(
                                  "Total",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(.7)),
                                )),
                              ),
                              Container(
                                height: 50,
                                child: Center(
                                    child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Text(
                                    tn,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black.withOpacity(.7)),
                                  ),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * .03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 100,
                    width: screenWidth * .915,
                    decoration: BoxDecoration(
                      //border: Border.all(color: Colors.grey),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      //borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Container(
                            height: 100,
                            width: screenWidth * .277,
                            child: Lottie.network(
                                "https://assets6.lottiefiles.com/packages/lf20_wgz45thc.json"),
                          ),
                          Container(
                            height: 100,
                            width: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "How much have you progressed last week?",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, right: 30),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Rate yourself",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Container(
                                          height: 10,
                                          width: 60,
                                          child: Lottie.network(
                                              "https://assets6.lottiefiles.com/packages/lf20_L1eVBx.json"))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
