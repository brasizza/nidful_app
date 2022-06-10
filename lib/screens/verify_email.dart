// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/utils/utils.dart';
import 'package:nidful/widgets/bottom_bar.dart';
import 'package:nidful/widgets/color_button.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;
  Timer? timer;
  bool canResendEmail = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future checkEmailVerified() async {
    // reload
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'too-many-requests') {
        Get.snackbar(
          'Error',
          'Too many requests. Please try again later.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? BottomBar()
        : Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: Stack(
                      // fit: StackFit.expand,
                      overflow: Overflow.visible,
                      children: [
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.001 * -5,
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
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 1 / 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Confirm Email',
                          style: GoogleFonts.workSans(
                              color: Colors.black,
                              fontSize: 35.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'We sent an email confirmation message to your mail ${FirebaseAuth.instance.currentUser!.email}. Open your mail to check.',
                          style: GoogleFonts.workSans(color: Colors.black),
                        ),
                        // SizedBox(
                        //   height: 30,
                        // ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 30,
                        ),
                        Button(
                          label: 'Resend Email',
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 15,
                          fontsize: 20.sp,
                          function: () {
                            showSnackBar('Email sent', context);
                            canResendEmail ? sendVerificationEmail() : null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
