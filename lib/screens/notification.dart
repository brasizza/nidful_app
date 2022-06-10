// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/constant/constants.dart';
import 'package:nidful/widgets/accepted.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:nidful/widgets/notifications_list.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  var notifications = [];
  @override
  initState() {
    super.initState();
    getNotifications();
  }

  getNotifications() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('notifications')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('userNotifications')
        // .orderBy('timestamp', descending: true)
        .limit(50)
        .get();
    snapshot.docs.forEach((doc) {
      // print('${doc.data()}');
    });

    setState(() {
      notifications = snapshot.docs;
    });
    // print(snapshot.docs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Notifications",
          style: GoogleFonts.workSans(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('notifications')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('userNotifications')
                        .orderBy('timestamp', descending: true)
                        .limit(50)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          child: Center(
                            child: LoadingAnimationWidget.inkDrop(
                                color: primaryColor, size: 50),
                          ),
                        );
                      }
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: (snapshot.data! as dynamic).docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return RefreshIndicator(
                            onRefresh: () async {
                              await getNotifications();
                            },
                            child: NotificationsList(
                              snap: (snapshot.data! as dynamic)
                                  .docs[index]
                                  .data(),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
