// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/widgets/color_button.dart';
import 'package:nidful/widgets/input_field.dart';

class Editprofile extends StatelessWidget {
  const Editprofile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          "Edit Profile",
          style: GoogleFonts.workSans(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: CircleAvatar(
                    minRadius: 50,
                    maxRadius: 50,
                    backgroundImage: AssetImage('assets/profile_image.png'),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      InputWidget(label: 'First Name'),
                      SizedBox(
                        height: 20,
                      ),
                      InputWidget(label: 'Last Name'),
                      SizedBox(
                        height: 20,
                      ),
                      InputWidget(label: 'Username'),
                      SizedBox(
                        height: 20,
                      ),
                      InputWidget(label: 'Email address'),
                      SizedBox(
                        height: 20,
                      ),
                      Button(
                        label: 'Update Info',
                        width: 400,
                        height: 60,
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
