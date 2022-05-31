// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/screens/detail_page.dart';
import 'package:nidful/widgets/circle_icon.dart';

class NotificationsList extends StatefulWidget {
  final snap;
  const NotificationsList({Key? key, this.snap}) : super(key: key);

  @override
  State<NotificationsList> createState() => _NotificationsListState();
}

class _NotificationsListState extends State<NotificationsList> {
  var data;
  @override
  void initState() {
    super.initState();
    getProduct();
  }

  void getProduct() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('products')
        .doc(widget.snap['postId'])
        .get();
    setState(() {
      data = snap.data();
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // print(snap);
        Get.to(
          () => DetailPage(
            snap: data,
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(children: [
              CircleIcon(
                icon: Icons.notifications_outlined,
                iconSize: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.snap['type'] == 'requesting'
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Comrade 🌟',
                              style: GoogleFonts.workSans(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              "${widget.snap['username']} requesting for a product",
                              style: GoogleFonts.workSans(fontSize: 10),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Comrade 🌟',
                              style: GoogleFonts.workSans(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              'John wants to gift you macbook',
                              style: GoogleFonts.workSans(fontSize: 10),
                            ),
                          ],
                        ),
                ],
              ),
            ]),
          ),
          Icon(Icons.arrow_forward_outlined),
        ],
      ),
    );
  }
}
