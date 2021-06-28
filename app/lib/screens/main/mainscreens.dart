import 'package:app/GoogleSignIn/google_sign.dart';
import 'package:app/screens/splashscreen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: screenHeight,
                                child:Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        height:30,
                                        //color: Colors.black,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.circular(6),
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
                                        child: Center(
                                          child: Text(user!.email!,overflow: TextOverflow.ellipsis,),
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Container(
                                        height:200,
                                        //color: Colors.black,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.circular(6),
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
                                      ),
                                      SizedBox(height: 20,),
                                      Container(
                                        height:40,
                                        //color: Colors.black,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.circular(6),
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
                                        child: isPressed?SplashScreen():ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(Colors.black),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              isPressed = true;
                                            });
                                            final provider =
                                            Provider.of<GoogleSignInProvider>(context, listen: false);
                                            provider.logOut();

                                          },
                                          child: Text("Login Out",style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),),
                                        ),
                                      ),

                                    ],
                                  ),
                                )
                              );
                            });
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

