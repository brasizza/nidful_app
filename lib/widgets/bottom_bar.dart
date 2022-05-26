// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    ProfilePage(uid: FirebaseAuth.instance.currentUser!.uid),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: BottomNavigationBar(
          currentIndex: index,
          onTap: (index) => setState(() => this.index = index),
          elevation: 0,
          items: [
            BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == 0 ? primaryColor : Colors.transparent,
                  ),
                  child: SvgPicture.asset(
                    'assets/HOME.svg',
                    semanticsLabel: 'HOME',
                    color: index == 0 ? Colors.white : primaryColor,
                  ),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == 1 ? primaryColor : Colors.transparent,
                  ),
                  child: SvgPicture.asset(
                    'assets/EXPLORE.svg',
                    semanticsLabel: 'EXPLORE',
                    color: index == 1 ? Colors.white : primaryColor,
                  ),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == 2 ? primaryColor : Colors.transparent,
                  ),
                  child: SvgPicture.asset(
                    'assets/NOTIFICATION.svg',
                    semanticsLabel: 'NOTIFICATION',
                    color: index == 2 ? Colors.white : primaryColor,
                  ),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == 3 ? primaryColor : Colors.transparent,
                  ),
                  child: SvgPicture.asset(
                    'assets/USER.svg',
                    semanticsLabel: 'USER',
                    color: index == 3 ? Colors.white : primaryColor,
                  ),
                ),
                label: ''),
          ],
        ),
      ),
    );
  }
}
