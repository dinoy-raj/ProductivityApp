import 'package:flutter/material.dart';

class TodoComment extends StatefulWidget {
  double screenWidth;
  TodoComment(this.screenWidth);

  @override
  _TodoCommentState createState() => _TodoCommentState();
}

class _TodoCommentState extends State<TodoComment> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Text("Comment"),
    );
  }
}
