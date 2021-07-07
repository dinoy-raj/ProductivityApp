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
          child: Center(
        child: Text("Tutorial"),
      )),
    );
  }
}
