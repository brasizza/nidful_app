// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/constant/constants.dart';

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

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
            child: Image.asset('assets/slide2.png'),
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
              'Need Something?',
              style: GoogleFonts.workSans(
                  fontSize: 20,
                  color: primaryColor,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            Text(
              'The best gifts are freely given. Explore the app to find amazing household items, furniture, gadgets, and more at zero cost. ',
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
