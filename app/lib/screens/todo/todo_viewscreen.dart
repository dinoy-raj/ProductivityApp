import 'package:flutter/material.dart';

class TodoView extends StatefulWidget {
  Map<String, dynamic> data;
  TodoView(this.data);


  @override
  _TodoViewState createState() => _TodoViewState(data);
}

class _TodoViewState extends State<TodoView> {
  Map<String, dynamic> data;
  _TodoViewState(this.data);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(data["title"]),
      ),
    );
  }
}
