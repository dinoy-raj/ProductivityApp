import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class ReportIssue extends StatefulWidget {
  const ReportIssue({Key? key}) : super(key: key);

  @override
  _ReportIssueState createState() => _ReportIssueState();
}

class _ReportIssueState extends State<ReportIssue> {
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
                            Container(
                              height: 20,
                            ),
                            
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          )
      ),
    );
  }
}
