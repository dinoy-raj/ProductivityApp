import 'package:flutter/material.dart';

class ListView2 extends StatefulWidget {
  const ListView2({Key? key}) : super(key: key);

  @override
  _ListView2State createState() => _ListView2State();
}

class _ListView2State extends State<ListView2> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      children: [
        Container(
          height: 40,
          width: 100,
          child: Text("hi"),
          color: Colors.red,
        ),
        Container(
          height: 40,
          width: 100,
          child: Text("hi"),
          color: Colors.red,
        ),
        Container(
          height: 40,
          width: 100,
          child: Text("hi"),
          color: Colors.red,
        ),
        Container(
          height: 40,
          width: 100,
          child: Text("hi"),
          color: Colors.red,
        ),

      ],
    );;
  }
}
