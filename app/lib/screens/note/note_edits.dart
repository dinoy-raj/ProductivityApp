import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoteEditing extends StatefulWidget {
  const NoteEditing({Key? key}) : super(key: key);

  @override
  _NoteEditingState createState() => _NoteEditingState();
}

class _NoteEditingState extends State<NoteEditing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.cancel,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            // Text(
            //   "Your Notes",
            //   style: TextStyle(
            //       fontWeight: FontWeight.bold, fontSize: 40),
            // ),
          ],
        ),
      ),
    );
  }
}
