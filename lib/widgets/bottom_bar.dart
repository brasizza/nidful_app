// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:nidful/constant/constants.dart';
import 'package:nidful/providers/user_provider.dart';
import 'package:nidful/screens/notification.dart';
import 'package:nidful/screens/explore_page.dart';
import 'package:nidful/screens/home.dart';
import 'package:nidful/screens/profile_page.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  var index = 0;

  final screens = [
    HomePage(),
    ExplorePage(),
    NotificationPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: primaryColor,
        ),
        child: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          animationDuration: Duration(seconds: 2),
          height: 60,
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() => this.index = index),
          backgroundColor: Colors.white,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home),
              selectedIcon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.explore),
              selectedIcon: Icon(
                Icons.explore,
                color: Colors.white,
              ),
              label: 'Explore',
            ),
            NavigationDestination(
              icon: Icon(Icons.notifications),
              selectedIcon: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              label: 'Notifications',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              selectedIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
