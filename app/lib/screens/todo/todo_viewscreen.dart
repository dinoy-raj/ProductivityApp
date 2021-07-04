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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        leading: IconButton(
            splashRadius: 10,
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
            icon: Tooltip(
              message: "Exit Todo View",
              child: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.black,
                size: 23,
              ),
            )),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [

            ],
          ),
      ),
    );
  }
}
