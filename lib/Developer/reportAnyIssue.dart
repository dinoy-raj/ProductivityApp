import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportIssue extends StatefulWidget {
  const ReportIssue({Key? key}) : super(key: key);

  @override
  _ReportIssueState createState() => _ReportIssueState();
}

class _ReportIssueState extends State<ReportIssue> {
  static const _lind = 'https://www.linkedin.com/in/dinoy-raj-k/';
  void _launchlind() async => await canLaunch(_lind)
      ? await launch(_lind)
      : throw 'Could not launch $_lind';

  final Uri emailLaunchUrid = Uri(
    scheme: 'mailto',
    path: 'dinoykraj@gmail.com,amalnathm7@gmail.com',
  );

  static const _lina = 'https://www.linkedin.com/in/amal-nath-m-1ba12a192/';
  void _launchlina() async => await canLaunch(_lind)
      ? await launch(_lina)
      : throw 'Could not launch $_lina';

  final Uri emailLaunchUria = Uri(
    scheme: 'mailto',
    path: ' amalnathm7@gmail.com',
  );
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
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
              message: "Exit",
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
                                "Do - It",
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
                            Container(
                              height: 20,
                            ),
                            
                          ],
                        ),
                      ],
                    )),
                SizedBox(height: 50,),
                Container(
                  width: screenWidth,
                  height: 100,
                  child: Center(child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("If You Face Any Issue Always Feel Free To Share With Us",
                      textAlign: TextAlign.center
                      ,
                      style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      height: 2/1,
                      color: Colors.grey,
                    ),),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 100,
                        width: screenWidth * .8,
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
                                "Mail Us",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black.withOpacity(.4),
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                  height: 40,
                                  width: screenWidth * .6,
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
                                      "Click Here",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black.withOpacity(.7)),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),



              ],
            ),
          )
      ),
    );
  }
}
