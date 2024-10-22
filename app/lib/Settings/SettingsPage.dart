import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool val = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
              message: "Exit Settings",
              child: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.black,
              ),
            )),
      ),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 600,
                    width: screenWidth,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: screenWidth * .8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.settings,
                                size: 14,
                                color: Colors.black.withOpacity(.5),
                              ),
                              Container(
                                width: 5,
                              ),
                              Text(
                                "Settings",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(.5),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          height: 430,
                          width: screenWidth * .8,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white.withOpacity(.8),
                            //border: Border.all(color: Colors.white, width: 1),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.black.withOpacity(.1),
                            //     blurRadius: 100,
                            //     spreadRadius: 2,
                            //     offset: Offset(0, 3),
                            //   ),
                            // ]
                            //borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
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
                                height: 60,
                                width: screenWidth * .7,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: screenHeight * .06,
                                        width: 100,
                                        child: Center(
                                          child: Text(
                                            "Dark Mode",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 20,
                                        child: CupertinoSwitch(
                                          value: false,
                                          onChanged: (bool val) {
                                            setState(() {
                                              val = !val;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 70,
                          width: screenWidth * .8,
                          child: Center(
                            child: Text(
                              "* Most of the features are under development. This page will be updated soon.",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.withOpacity(.5)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
