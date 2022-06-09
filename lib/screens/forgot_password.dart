// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(20)),
      child: SafeArea(
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
                  controller: _emailController,
                  label: 'Email Address',
                  hint: 'johndoe@email.com',
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Button(
                    function: () async {
                      setState(() {
                        isLoading = true;
                      });
                      if (_emailController.text.isEmpty) {
                        Get.snackbar(
                          'Error',
                          'Please enter your email address',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                          borderRadius: 10,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                        );
                        setState(() {
                          isLoading = false;
                        });
                      } else if (!_emailController.text.isEmail) {
                        Get.snackbar(
                          'Error',
                          'Please enter a valid email address',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                          borderRadius: 10,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                        );
                        setState(() {
                          isLoading = false;
                        });
                      } else {
                        await FirebaseAuth.instance.sendPasswordResetEmail(
                            email: _emailController.text);
                        Get.snackbar(
                          'Success',
                          'Password reset email sent',
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                          borderRadius: 10,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                        );
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    load: isLoading
                        ? Center(child: CircularProgressIndicator())
                        : Text(
                            'Get Reset Link',
                            style: GoogleFonts.workSans(
                                color: Colors.white, fontSize: 20),
                          ),
                    label: 'Get Reset Link',
                    width: double.infinity,
                    height: 50,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
      ),
    ));
  }
}
