import 'package:app/screens/main/mainscreens.dart';
import 'package:app/screens/note/notescreen.dart';
import 'package:app/screens/projects/projectscreen.dart';
import 'package:app/screens/todo/todoscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NavBarNew extends StatefulWidget {
  const NavBarNew({Key? key}) : super(key: key);

  @override
  _NavBarNewState createState() => _NavBarNewState();
}

class _NavBarNewState extends State<NavBarNew> {

  List<Widget> _buildScreens() {
    return [
      MainScreen(),
      PersonalScreen(),
      NotesScreen(),
      ProjectScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          MainScreen(),
          PersonalScreen(),
          NotesScreen(),
          ProjectScreen(),
        ]
      ),
      bottomNavigationBar: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NeumorphicButton(
              onPressed: (){},
              child: Icon(CupertinoIcons.home),
            ),
            NeumorphicButton(
              onPressed: (){},
              child: Icon(CupertinoIcons.square_list),
            ),
            NeumorphicButton(
              onPressed: (){},
              child: Icon(CupertinoIcons.square_favorites_alt_fill),
            ),
            NeumorphicButton(
              onPressed: (){},
              child: Icon(CupertinoIcons.group_solid),
            ),
          ],
        ),
      ),
    );
    
  }
}
