// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/screens/chat_page.dart';
import 'package:nidful/widgets/messages.dart';

class MessageList extends StatelessWidget {
  const MessageList({Key? key}) : super(key: key);

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
          "Messages",
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
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          Get.to(() => ChatPage(
                                receiver:
                                    FirebaseAuth.instance.currentUser!.uid,
                              ));
                        },
                        child: Messages());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
