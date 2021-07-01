import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  static const _lind = 'https://www.linkedin.com/in/dinoy-raj-k/';
  void _launchlind() async => await canLaunch(_lind)
      ? await launch(_lind)
      : throw 'Could not launch $_lind';

  final Uri emailLaunchUrid = Uri(
    scheme: 'mailto',
    path: 'dinoykraj@gmail.com',
  );

  static const _lina = 'https://www.linkedin.com/in/amal-nath-m-1ba12a192/';
  void _launchlina() async => await canLaunch(_lind)
      ? await launch(_lind)
      : throw 'Could not launch $_lind';

  final Uri emailLaunchUria = Uri(
    scheme: 'mailto',
    path: ' amalnathm7@gmail.com',
  );

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        leading: IconButton(
            splashRadius: 20,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.black,
              ),
            )),

      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: screenHeight * .15,
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
                                "Lets Do It",
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
                            Container(
                              height: 20,
                              child: DefaultTextStyle(
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                                child: AnimatedTextKit(
                                  repeatForever: true,
                                  animatedTexts: [
                                    FadeAnimatedText('do IT!'),
                                    FadeAnimatedText('do it RIGHT!!'),
                                    FadeAnimatedText('do it RIGHT NOW!!!'),
                                  ],
                                  onTap: () {
                                    print("Tap Event");
                                  },
                                ),
                              ),
                            ),
                            Text(
                              "Complete Analysis Of Your Activities",
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
                  height: 20,
                ),
                Container(
                  height: screenHeight * .2,
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
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 20,
                          width: 5,
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
                        ),
                        Container(
                          width: 10,
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Container(
                                  height: screenHeight * .15,
                                  width: screenWidth * .8,
                                  child: Center(
                                    child: Text(
                                      "Lets Do It Is An CrossPlatform Productivity App With Personalized Todo And Notes Section. It Also Comes With Project Tab Where We Can Schedule Projects Add Our Colleagues As Collaborators  ",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                          wordSpacing: 2,
                                          height: 1.7 / 1
                                          //fontWeight: FontWeight.bold,

                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ])
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: screenHeight * .6,
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 30,
                          child: Text(
                            "Developers",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 20),
                          ),
                        ),
                        Container(
                          height: 4,
                          width: 80,
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
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: screenHeight * .3,
                                width: screenWidth * .4,
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
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: 120,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          color: Colors.white,
                                          //border: Border.all(color: Colors.white10, width: 1),
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
                                        child: Image.network(
                                            "https://avatars.githubusercontent.com/u/62199728?s=400&u=979000468dc7622a0655d6c6200e71f16c0034a3&v=4"),
                                      ),
                                      Text(
                                        "Dinoy Raj",
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(.5),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "| Student | Flutter Devloper |",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: screenHeight * .3,
                                width: screenWidth * .4,
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
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: 120,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          color: Colors.white,
                                          //border: Border.all(color: Colors.white10, width: 1),
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
                                        child: Image.network(
                                            "https://avatars.githubusercontent.com/u/64605131?v=4"),
                                      ),
                                      Text(
                                        "Amal Nath",
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(.5),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "| Student | Flutter Devloper |",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: screenHeight * .13,
                                width: screenWidth * .4,
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
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Connect",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black.withOpacity(.4),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                          height: 30,
                                          width: screenWidth * .35,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              launch(
                                                  emailLaunchUrid.toString());
                                            },
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.white10),
                                                elevation:
                                                    MaterialStateProperty.all(
                                                        0),
                                                side: MaterialStateProperty.all(
                                                    BorderSide(
                                                        color: Colors.white))),
                                            child: Text(
                                              "Gmail",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey),
                                            ),
                                          )),
                                      Container(
                                          height: 30,
                                          width: screenWidth * .35,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.white10),
                                                elevation:
                                                    MaterialStateProperty.all(
                                                        0),
                                                side: MaterialStateProperty.all(
                                                    BorderSide(
                                                        color: Colors.white))),
                                            onPressed: () {
                                              _launchlind();
                                            },
                                            child: Text(
                                              "Linkedin",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: screenHeight * .13,
                                width: screenWidth * .4,
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
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Connect",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black.withOpacity(.4),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                          height: 30,
                                          width: screenWidth * .35,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              launch(
                                                  emailLaunchUria.toString());
                                            },
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.white10),
                                                elevation:
                                                    MaterialStateProperty.all(
                                                        0),
                                                side: MaterialStateProperty.all(
                                                    BorderSide(
                                                        color: Colors.white))),
                                            child: Text(
                                              "Gmail",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey),
                                            ),
                                          )),
                                      Container(
                                          height: 30,
                                          width: screenWidth * .35,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.white10),
                                                elevation:
                                                    MaterialStateProperty.all(
                                                        0),
                                                side: MaterialStateProperty.all(
                                                    BorderSide(
                                                        color: Colors.white))),
                                            onPressed: () {
                                              _launchlina();
                                            },
                                            child: Text(
                                              "Linkedin",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
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
