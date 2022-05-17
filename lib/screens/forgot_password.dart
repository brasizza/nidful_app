// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/screens/login.dart';
import 'package:nidful/widgets/color_button.dart';
import 'package:nidful/widgets/input_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Forgot Password',
                style: GoogleFonts.workSans(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 16),
              Text(
                'Reset your account password here',
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
                height: 30,
              ),
              Center(
                child: Button(
                  label: 'Get Reset Link',
                  width: double.infinity,
                  height: 50,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                InkWell(
                  onTap: () {
                    Get.to(() => LoginPage());
                  },
                  child: Row(children: [
                    Icon(
                      Icons.arrow_back_ios,
                      size: 18,
                    ),
                    Text(
                      'Back to Login',
                      style: GoogleFonts.workSans(),
                    )
                  ]),
                ),
              ])
            ],
          ),
        ),
      ),
    ));
  }
}
