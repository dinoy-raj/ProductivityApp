import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

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
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
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
                padding: const EdgeInsets.only(left: 15.0, right: 15, top: 20),
                child: Row(
                  children: [
                    Container(
                      //color: Colors.black,
                      height: 40,
                      width: 40,
                      child: Icon(
                        FeatherIcons.checkCircle,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        CupertinoContextMenu(
                          actions: [
                            CupertinoContextMenuAction(child: Text(user!.email!)),
                            CupertinoContextMenuAction(child: Text("Settings")),
                            CupertinoContextMenuAction(child: Text("Logout")),
                          ],
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    //fit: BoxFit.fill,
                                    image: NetworkImage(user!.photoURL!)),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
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
                        );
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                //fit: BoxFit.fill,
                                image: NetworkImage(user!.photoURL!)),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
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
