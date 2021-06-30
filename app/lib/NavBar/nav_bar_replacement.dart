import 'package:app/screens/main/mainscreens.dart';
import 'package:app/screens/note/notescreen.dart';
import 'package:app/screens/projects/projectscreen.dart';
import 'package:app/screens/todo/todoscreen.dart';
import 'package:flutter/material.dart';

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
    return PageView(

    );
  }
}
