// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_final_fields

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:nidful/constant/constants.dart';
import 'package:nidful/screens/notification.dart';
import 'package:nidful/screens/explore_page.dart';
import 'package:nidful/screens/home.dart';
import 'package:nidful/screens/profile_page.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
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
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 500),
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: primaryColor,
        color: primaryColor,
        height: 50,
        items: [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.explore,
            color: Colors.white,
          ),
          Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            color: Colors.white,
          ),
        ],
        onTap: (index) => setState(() => this.index = index),
      ),
    );
  }
}
