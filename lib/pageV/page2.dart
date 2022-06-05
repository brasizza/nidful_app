// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors,  prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/constant/constants.dart';

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            // fit: StackFit.expand,
            overflow: Overflow.visible,
            children: [
              Positioned(
                top: -20,
                right: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.45,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/slide2.png'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        // Expanded(child: Container()),
        Container(
          child: Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Text(
                    'Need Something?',
                    style: GoogleFonts.workSans(
                      fontSize: 25,
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'The best gifts are freely given. Explore the app to find amazing household items, furniture, gadgets, and more at zero cost. ',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.workSans(
                      fontSize: 20.sp,
                      color: primaryColor,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.0,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
