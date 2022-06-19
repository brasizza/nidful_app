// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/constant/constants.dart';
import 'package:nidful/screens/login.dart';
import 'package:nidful/screens/register.dart';
import 'package:nidful/widgets/color_button.dart';

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Positioned(
            top: MediaQuery.of(context).size.height * 0.001 * -1,
            right: MediaQuery.of(context).size.width / 1000 * -0,
            child: Container(
              width: MediaQuery.of(context).size.width * 1.1,
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/slide3.png'),
                ),
              ),
            ),
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
                    'Show Love',
                    style: GoogleFonts.workSans(
                      fontSize: 25,
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Your clutters are Nidful. Make donations a constant way of life by gifting items to someone who genuinely needs them using the Giveaway features.',
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
        // SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        Expanded(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: InkWell(
                onTap: () {
                  Get.to(() => RegisterPage());
                },
                child: Button(
                  label: 'Get Started',
                  fontsize: 15,
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: InkWell(
                onTap: () {
                  Get.to(() => LoginPage());
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: primaryColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      'Sign In',
                      style: GoogleFonts.workSans(
                          fontSize: 15, color: primaryColor),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
