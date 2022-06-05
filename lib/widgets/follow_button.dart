// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FollowButton extends StatelessWidget {
  final String? label;
  final Color? buttonColor;
  final Color? textColor;
  final Function? onPressed;
  const FollowButton(
      {Key? key, this.label, this.buttonColor, this.textColor, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 30,
      decoration: BoxDecoration(
        color: buttonColor ?? Colors.black,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          label ?? 'Following',
          style: GoogleFonts.workSans(color: textColor ?? Colors.white),
        ),
      ),
    );
  }
}
