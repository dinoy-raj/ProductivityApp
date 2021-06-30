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

  int _selectedIndex = 0;
  PageController _controlerPage = PageController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      body: PageView(
        controller: _controlerPage,
        pageSnapping: true,
        onPageChanged: (index) {
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
        height: screenHeight * .2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NeumorphicButton(
              style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                  //depth: 8,
                  lightSource: LightSource.topLeft,
                  color: Colors.white),
              onPressed: () {
                setState(() {
                  int prev = _selectedIndex;
                  _selectedIndex = 0;

                  int diff = prev - _selectedIndex;
                  diff.abs() > 1
                      ? _controlerPage.jumpToPage(_selectedIndex)
                      : _controlerPage.animateToPage(_selectedIndex,
                          duration: Duration(milliseconds: 900),
                          curve: Curves.ease);
                });
              },
              child: _selectedIndex == 0
                  ? Icon(CupertinoIcons.house_fill)
                  : Icon(CupertinoIcons.house),
            ),
            NeumorphicButton(
              style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                  //depth: 8,
                  lightSource: LightSource.topLeft,
                  color: Colors.white),
              onPressed: () {
                setState(() {
                  int prev = _selectedIndex;
                  _selectedIndex = 1;

                  int diff = prev - _selectedIndex;
                  diff.abs() > 1
                      ? _controlerPage.jumpToPage(_selectedIndex)
                      : _controlerPage.animateToPage(_selectedIndex,
                          duration: Duration(milliseconds: 900),
                          curve: Curves.ease);
                });
              },
              child: _selectedIndex == 1
                  ? Icon(CupertinoIcons.square_favorites_fill)
                  : Icon(CupertinoIcons.square_favorites),
            ),
            NeumorphicButton(
              style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                  //depth: 8,
                  lightSource: LightSource.topLeft,
                  color: Colors.white),
              onPressed: () {
                setState(() {
                  int prev = _selectedIndex;
                  _selectedIndex = 2;

                  int diff = prev - _selectedIndex;
                  diff.abs() > 1
                      ? _controlerPage.jumpToPage(_selectedIndex)
                      : _controlerPage.animateToPage(_selectedIndex,
                          duration: Duration(milliseconds: 900),
                          curve: Curves.ease);
                });
              },
              child: _selectedIndex == 2
                  ? Icon(CupertinoIcons.square_favorites_alt_fill)
                  : Icon(CupertinoIcons.square_favorites_alt),
            ),
            NeumorphicButton(
              style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                  //depth: 8,
                  lightSource: LightSource.topLeft,
                  color: Colors.white),
              onPressed: () {
                setState(() {
                  int prev = _selectedIndex;
                  _selectedIndex = 3;

                  int diff = prev-_selectedIndex;
                  diff.abs()>1?_controlerPage.jumpToPage(_selectedIndex):_controlerPage.animateToPage(_selectedIndex,  duration: Duration(milliseconds: 900),
                      curve: Curves.ease);
                });
              },
              child: _selectedIndex == 3
                  ? Icon(
                      CupertinoIcons.group_solid,
                      size: 27,
                    )
                  : Icon(
                      CupertinoIcons.group,
                      size: 27,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
