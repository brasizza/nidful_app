// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/widgets/circle_icon.dart';

class NotificationsList extends StatelessWidget {
  const NotificationsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
                Text(
                  'Lucky Comrade 🌟',
                  style: GoogleFonts.workSans(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  'John wants to gift you macbook',
                  style: GoogleFonts.workSans(fontSize: 10),
                ),
              ],
            ),
          ]),
        ),
        Icon(Icons.arrow_forward_outlined),
      ],
    );
  }
}
