// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nidful/constant/constants.dart';
import 'package:nidful/screens/register.dart';
import 'package:nidful/widgets/color_button.dart';

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

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
            child: Image.asset('assets/slide3.png'),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          padding: EdgeInsets.all(29),
          child: Text(
            'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las',
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 1.0),
            maxLines: 3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Button(
            label: 'Get Started',
            width: 400,
            height: 60,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: InkWell(
            onTap: () {
              Get.to(() => RegisterPage());
            },
            child: Container(
              width: 400,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: primaryColor),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  'Sign In',
                  style: TextStyle(color: primaryColor),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
