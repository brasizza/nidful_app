// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/constant/constants.dart';
import 'package:nidful/screens/login.dart';
import 'package:nidful/widgets/color_button.dart';
import 'package:nidful/widgets/input_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  'Create an Account',
                  style: GoogleFonts.workSans(
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 16),
                Text(
                  'Create an account to continue an awesome experience',
                  style: GoogleFonts.workSans(color: Colors.black),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 16,
                ),
                InputWidget(
                  label: 'Username',
                  hint: 'johndoe',
                ),
                SizedBox(
                  height: 16,
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
                  child: Button(
                    label: 'Create Account',
                    width: double.infinity,
                    height: 50,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => LoginPage());
                  },
                  child: RichText(
                      text: TextSpan(
                    text: 'Already have an account? ',
                    style: GoogleFonts.workSans(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Login',
                        style: GoogleFonts.workSans(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
