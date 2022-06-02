// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
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
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 350,
            width: 510,
            // color: Colors.red,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image.asset('assets/slide3.png'),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.all(29),
            // ignore: prefer_const_literals_to_create_immutables
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Show Love',
                style: GoogleFonts.workSans(
                    fontSize: 20,
                    color: primaryColor,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              Text(
                'Your clutters are Nidful. Make donations a constant way of life by gifting items to someone who genuinely needs them using the Giveaway features.',
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: InkWell(
              onTap: () {
                Get.to(() => RegisterPage());
              },
              child: Button(
                label: 'Get Started',
                fontsize: 16,
                width: 400,
                height: 40,
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
                width: 400,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: primaryColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'Sign In',
                    style:
                        GoogleFonts.workSans(fontSize: 16, color: primaryColor),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
