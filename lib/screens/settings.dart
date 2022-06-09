// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'dart:math';

import 'package:flutter_switch/flutter_switch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nidful/models/user.dart' as model;
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/providers/user_provider.dart';
import 'package:nidful/screens/edit_profile.dart';
import 'package:nidful/screens/security_page.dart';
import 'package:provider/provider.dart';

class Settingpage extends StatefulWidget {
  const Settingpage({Key? key}) : super(key: key);

  @override
  State<Settingpage> createState() => _SettingpageState();
}

class _SettingpageState extends State<Settingpage> {
  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;

    bool status = false;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        title: Text(
          "Settings",
          style: GoogleFonts.workSans(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: user.photoUrl == ''
                      ? CircleAvatar(
                          minRadius: 50,
                          maxRadius: 50,
                          // generate random background color
                          backgroundColor: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)],
                          child: Center(
                            child: Text(
                              user.username.toUpperCase().substring(0, 1),
                              style: GoogleFonts.workSans(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        )
                      : CircleAvatar(
                          minRadius: 50,
                          maxRadius: 50,
                          backgroundImage: NetworkImage(user.photoUrl),
                        ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 26.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(() => Editprofile());
                        },
                        child: Text(
                          'Edit Profile',
                          style: GoogleFonts.workSans(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Customer care',
                        style: GoogleFonts.workSans(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Allow Chat',
                              style: GoogleFonts.workSans(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            // Custom Switcher
                            FlutterSwitch(
                              width: 80.0,
                              height: 35.0,
                              valueFontSize: 20.0,
                              toggleSize: 25.0,
                              value: status,
                              borderRadius: 30.0,
                              padding: 8.0,
                              showOnOff: true,
                              onToggle: (val) {
                                setState(() {
                                  status = !val;
                                });
                              },
                            ),
                          ]),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Privacy',
                        style: GoogleFonts.workSans(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => SecurityPage());
                        },
                        child: Text(
                          'Security',
                          style: GoogleFonts.workSans(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                        },
                        child: Text(
                          'Sign Out',
                          style: GoogleFonts.workSans(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
