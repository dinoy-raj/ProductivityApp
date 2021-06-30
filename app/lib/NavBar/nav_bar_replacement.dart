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

  int _selectedIndex=0;
  PageController _controlerPage = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controlerPage,
        pageSnapping: true,

        onPageChanged:(index){
          setState(() {
          _selectedIndex = index;
          print(index);
          });
        },
        children: [
          MainScreen(),
          PersonalScreen(),
          NotesScreen(),
          ProjectScreen(),
        ],

      ),
      bottomNavigationBar: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NeumorphicButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                  _controlerPage.animateToPage(_selectedIndex, duration: Duration(milliseconds: 200), curve:Curves.ease );
                });

              },
              child: Icon(CupertinoIcons.home),
            ),
            NeumorphicButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                  _controlerPage.animateToPage(_selectedIndex, duration: Duration(milliseconds: 200), curve:Curves.ease );
                });

              },
              child: Icon(CupertinoIcons.square_list),
            ),
            NeumorphicButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = 2;
                  _controlerPage.animateToPage(_selectedIndex, duration: Duration(milliseconds: 200), curve:Curves.ease );

                });

              },
              child: Icon(CupertinoIcons.square_favorites_alt_fill),
            ),
            NeumorphicButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = 3;
                  _controlerPage.animateToPage(_selectedIndex, duration: Duration(milliseconds: 200), curve:Curves.ease );

                });

              },
              child: Icon(CupertinoIcons.group_solid),
            ),
          ],
        ),
      ),
    );
  }
}