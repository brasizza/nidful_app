// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/constant/constants.dart';

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 350,
          width: 510,
          // color: Colors.red,
          child: FittedBox(
            fit: BoxFit.fill,
            child: Image.asset('assets/slide1.png'),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          padding: EdgeInsets.all(29),
          // ignore: prefer_const_literals_to_create_immutables
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Let Go',
              style: GoogleFonts.workSans(
                  fontSize: 20,
                  color: primaryColor,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            Text(
              'Feeling overwhelmed with too many items? Snap and upload it in a minute and wait for Nidful to bring someone who will appreciate your way',
              style: GoogleFonts.workSans(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.0,
                  height: 1.5),
              maxLines: 4,
            ),
          ]),
        ),
      ],
    );
  }
}
