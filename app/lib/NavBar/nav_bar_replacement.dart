import 'dart:async';

import 'package:app/screens/main/mainscreens.dart';
import 'package:app/screens/note/main%20view/notescreen.dart';
import 'package:app/screens/projects/group_voice_call.dart';
import 'package:app/screens/projects/projectscreen.dart';
import 'package:app/screens/todo/Todoview/todoscreen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NavBarNew extends StatefulWidget {
  const NavBarNew({Key? key}) : super(key: key);

  @override
  _NavBarNewState createState() => _NavBarNewState();
}

class _NavBarNewState extends State<NavBarNew> {
  int _selectedIndex = 0;
  PageController _controllerPage = PageController();
  Agora agora = Agora();

  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    listenToNetwork();
    Connectivity().checkConnectivity().then((value) {
      if (value == ConnectivityResult.none)
        Fluttertoast.showToast(
            msg:
                "No Internet connection detected. Some app functions might not work properly.");
    });
  }

  listenToNetwork() async {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none)
        Fluttertoast.showToast(
            msg:
                "No Internet connection detected. Some app functions might not work properly.");
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: PageView(
        controller: _controllerPage,
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
          ProjectScreen(agora),
        ],
      ),
      bottomNavigationBar: Container(
        height: screenHeight*.1<=60?60:screenHeight*.1,

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
                      ? _controllerPage.jumpToPage(_selectedIndex)
                      : _controllerPage.animateToPage(_selectedIndex,
                          duration: Duration(milliseconds: 300),
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
                      ? _controllerPage.jumpToPage(_selectedIndex)
                      : _controllerPage.animateToPage(_selectedIndex,
                          duration: Duration(milliseconds: 300),
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
                      ? _controllerPage.jumpToPage(_selectedIndex)
                      : _controllerPage.animateToPage(_selectedIndex,
                          duration: Duration(milliseconds: 300),
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

                  int diff = prev - _selectedIndex;
                  diff.abs() > 1
                      ? _controllerPage.jumpToPage(_selectedIndex)
                      : _controllerPage.animateToPage(_selectedIndex,
                          duration: Duration(milliseconds: 300),
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
