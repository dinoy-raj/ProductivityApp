import 'package:app/screens/splashscreen/splash_screen.dart';
import 'package:flutter/material.dart';

class Tutorial extends StatefulWidget {
  const Tutorial({Key? key}) : super(key: key);

  @override
  _TutorialState createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
        child:Center(
          child: Text("Tutorial"),
        )
    ),
    );
  }
}
