import 'package:do_it/Developer/aboutUsPage.dart';
import 'package:do_it/Developer/reportAnyIssue.dart';
import 'package:do_it/GoogleSignIn/google_sign.dart';
import 'package:do_it/Settings/SettingsPage.dart';
import 'package:do_it/Tutorial/tutorial.dart';
import 'package:do_it/screens/splashscreen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'mainscreen_body.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final user = FirebaseAuth.instance.currentUser;
  Color primaryClr = Colors.white;
  Color bgColor = Colors.black.withOpacity(.01);
  Color shadColor = Colors.black.withOpacity(.1);
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryClr,
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(children: [
            Container(
              // color: Colors.black,
              height: 100,
              child: Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.0416,
                    right: screenWidth * 0.0416,
                    top: 20),
                child: Row(
                  children: [
                    Container(
                      //color: Colors.black,
                      height: 40,
                      width: screenWidth * .12,
                      child: Icon(
                        FeatherIcons.checkCircle,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      splashColor: Colors.grey,
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                child: Container(
                                    height: 400,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 30,
                                            //color: Colors.black,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(.1),
                                                    blurRadius: 100,
                                                    spreadRadius: 2,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ]
                                                //borderRadius: BorderRadius.circular(10),
                                                ),
                                            child: Center(
                                              child: Text(
                                                user!.email!,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 200,
                                            width: screenWidth * .831,
                                            //color: Colors.black,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(.1),
                                                    blurRadius: 100,
                                                    spreadRadius: 2,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ]
                                                //borderRadius: BorderRadius.circular(10),
                                                ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  height: 45,
                                                  width: screenWidth * .831,
                                                  color: Colors.white,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  SettingsPage()));
                                                    },
                                                    style: ButtonStyle(
                                                      overlayColor:
                                                          MaterialStateProperty
                                                              .all(Colors.grey
                                                                  .withOpacity(
                                                                      .2)),
                                                      elevation:
                                                          MaterialStateProperty
                                                              .all(0),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(
                                                                  Colors.white),
                                                    ),
                                                    child: Text(
                                                      "Settings",
                                                      style: TextStyle(
                                                          //fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: .5,
                                                  width: screenWidth * .831,
                                                  color: Colors.grey,
                                                ),
                                                Container(
                                                  height: 45,
                                                  width: screenWidth * .831,
                                                  color: Colors.white,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ReportIssue()));
                                                    },
                                                    style: ButtonStyle(
                                                      overlayColor:
                                                          MaterialStateProperty
                                                              .all(Colors.grey
                                                                  .withOpacity(
                                                                      .2)),
                                                      elevation:
                                                          MaterialStateProperty
                                                              .all(0),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(
                                                                  Colors.white),
                                                    ),
                                                    child: Text(
                                                      "Report Issue",
                                                      style: TextStyle(
                                                          //fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: .5,
                                                  width: screenWidth * .831,
                                                  color: Colors.grey,
                                                ),
                                                Container(
                                                  height: 45,
                                                  width: screenWidth * .831,
                                                  color: Colors.white,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      AboutUs()));
                                                    },
                                                    style: ButtonStyle(
                                                      overlayColor:
                                                          MaterialStateProperty
                                                              .all(Colors.grey
                                                                  .withOpacity(
                                                                      .2)),
                                                      elevation:
                                                          MaterialStateProperty
                                                              .all(0),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(
                                                                  Colors.white),
                                                    ),
                                                    child: Text(
                                                      "About Us",
                                                      style: TextStyle(
                                                          //fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: .5,
                                                  width: screenWidth * .831,
                                                  color: Colors.grey,
                                                ),
                                                Container(
                                                  height: 45,
                                                  width: screenWidth * .831,
                                                  color: Colors.white,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Tutorial()));
                                                    },
                                                    style: ButtonStyle(
                                                      overlayColor:
                                                          MaterialStateProperty
                                                              .all(Colors.grey
                                                                  .withOpacity(
                                                                      .2)),
                                                      elevation:
                                                          MaterialStateProperty
                                                              .all(0),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(
                                                                  Colors.white),
                                                    ),
                                                    child: Text(
                                                      "Tutorial",
                                                      style: TextStyle(
                                                          //fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            height: 40,
                                            width: screenWidth * .831,
                                            //color: Colors.black,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(.1),
                                                    blurRadius: 100,
                                                    spreadRadius: 2,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ]
                                                //borderRadius: BorderRadius.circular(10),
                                                ),
                                            child: isPressed
                                                ? SplashScreen()
                                                : ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(
                                                                  Colors.black),
                                                    ),
                                                    onPressed: () async {
                                                      if (mounted)
                                                        setState(() {
                                                          isPressed = true;
                                                        });
                                                      final provider = Provider
                                                          .of<GoogleSignInProvider>(
                                                              context,
                                                              listen: false);
                                                      await provider.logOut();
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "Log out",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    )),
                              );
                            });
                      },
                      child: Container(
                        height: 60,
                        width: screenWidth * .166,
                        decoration: BoxDecoration(
                          //shape: BoxShape.circle,
                          borderRadius: BorderRadius.circular(20),
                          //color: Colors.red
                        ),
                        child: Center(
                          child: Container(
                            height: 40,
                            width: screenWidth * .1108,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    //fit: BoxFit.fill,
                                    image: NetworkImage(user!.photoURL!)),
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: shadColor,
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                    offset: Offset(0, 3),
                                  )
                                ]
                                //borderRadius: BorderRadius.circular(10),
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ScreenBody(),
          ]),
        ),
      ),
    );
  }
}
