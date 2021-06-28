import 'package:app/screens/splashscreen/splash_screen.dart';
import 'package:flutter/material.dart';

class ReportIssue extends StatefulWidget {
  const ReportIssue({Key? key}) : super(key: key);

  @override
  _ReportIssueState createState() => _ReportIssueState();
}

class _ReportIssueState extends State<ReportIssue> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
        body: SingleChildScrollView(
        child: SplashScreen(),
    ),
     );
  }
}
