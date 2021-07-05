import 'package:app/screens/main/mainscreens.dart';
import 'package:app/screens/note/main%20view/notescreen.dart';
import 'package:app/screens/projects/group_voice_call.dart';
import 'package:app/screens/todo/Todoview/todoscreen.dart';
import 'package:app/screens/projects/projectscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);
    Agora agora = Agora();
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(agora),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.

        hideNavigationBarWhenKeyboardShows:
            false, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.linearToEaseOut,
          duration: Duration(milliseconds: 300),
        ),
        navBarStyle: NavBarStyle
            .neumorphic, // Choose the nav bar style with this property.
      ),
    );
  }
}

List<Widget> _buildScreens(agora) {
  return [
    MainScreen(),
    PersonalScreen(),
    NotesScreen(),
    ProjectScreen(agora),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.house_fill),
      title: ("Home"),
      activeColorPrimary: CupertinoColors.black,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.person_2_alt),
      title: ("Settings"),
      activeColorPrimary: CupertinoColors.black,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.doc_text_fill),
      title: ("Settings"),
      activeColorPrimary: CupertinoColors.black,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.group_solid),
      title: ("Settings"),
      activeColorPrimary: CupertinoColors.black,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];
}
