// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/constant/constants.dart';
import 'package:nidful/resources/auth_methods.dart';
import 'package:nidful/screens/home.dart';
import 'package:nidful/screens/login.dart';
import 'package:nidful/screens/verify_email.dart';
import 'package:nidful/utils/utils.dart';
import 'package:nidful/widgets/bottom_bar.dart';
import 'package:nidful/widgets/color_button.dart';
import 'package:nidful/widgets/input_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethod().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      Get.snackbar(
        'Error',
        res,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 10,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
      );
    } else {
      Get.offAll(() => VerifyEmail());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: MediaQuery.of(context).size.height * 1 / 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
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
                    SizedBox(height: 15),
                    Text(
                      'Create an account to continue an awesome experience',
                      style: GoogleFonts.workSans(color: Colors.black),
                    ),
                    // SizedBox(
                    //   height: 30,
                    // ),
                    SizedBox(
                      height: 16,
                    ),
                    InputWidget(
                      height: MediaQuery.of(context).size.height / 13,
                      controller: _usernameController,
                      label: 'Username',
                      hint: 'johndoe',
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    InputWidget(
                      height: MediaQuery.of(context).size.height / 13,
                      controller: _emailController,
                      label: 'Email Address',
                      hint: 'johndoe@email.com',
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    InputWidget(
                      height: MediaQuery.of(context).size.height / 13,
                      controller: _passwordController,
                      label: 'Password',
                      isObscure: true,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Get.to(() => BottomBar());
                        },
                        child: InkWell(
                          onTap: signUpUser,
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 13,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: _isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      'Create Account',
                                      style: TextStyle(color: Colors.white),
                                    ),
                            ),
                          ),
                        ),
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
        ),
      ),
    );
  }
}
