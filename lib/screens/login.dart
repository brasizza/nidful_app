// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/constant/constants.dart';
import 'package:nidful/screens/forgot_password.dart';
import 'package:nidful/screens/home.dart';
import 'package:nidful/screens/register.dart';
import 'package:nidful/widgets/bottom_bar.dart';
import 'package:nidful/widgets/color_button.dart';
import 'package:nidful/widgets/input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        Container(
          height: 250,
          width: 500,
          // color: Colors.red,
          child: FittedBox(
            fit: BoxFit.fill,
            child: Image.asset('assets/slide3.png'),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign In',
                style: GoogleFonts.workSans(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 16),
              Text(
                'Sign in to continue an awesome experience',
                style: GoogleFonts.workSans(color: Colors.black),
              ),
              SizedBox(
                height: 30,
              ),
              InputWidget(
                label: 'Email Address',
                hint: 'johndoe@email.com',
              ),
              SizedBox(
                height: 16,
              ),
              InputWidget(
                label: 'Password',
                isObscure: true,
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Get.to(() => BottomBar());
                  },
                  child: Button(
                    label: 'Sign In',
                    width: double.infinity,
                    height: 50,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                InkWell(
                  onTap: () {
                    Get.to(() => RegisterPage());
                  },
                  child: RichText(
                      text: TextSpan(
                    text: 'Don\'t have an account? ',
                    style: GoogleFonts.workSans(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Register',
                        style: GoogleFonts.workSans(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => ForgotPasswordPage());
                  },
                  child: RichText(
                      text: TextSpan(
                    text: 'Forgot Password ',
                    style: GoogleFonts.workSans(color: Colors.black),
                  )),
                ),
              ])
            ],
          ),
        ),
      ]),
    ));
  }
}
