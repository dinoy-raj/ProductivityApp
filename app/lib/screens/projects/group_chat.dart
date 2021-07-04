import 'package:flutter/material.dart';

class GroupChat extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GroupChatState();
  }
}

class GroupChatState extends State<GroupChat> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      margin: EdgeInsets.only(
        left: screenWidth * .05,
        right: screenWidth * .05,
        top: screenHeight * .05,
        bottom: screenHeight * .05
      ),
      child: Column(
        children: [
          Container(
            child: TextField(

            ),
          )
        ],
      ),
    );
  }
}
