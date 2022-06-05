// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nidful/constant/constants.dart';
import 'package:nidful/resources/auth_methods.dart';
import 'package:nidful/screens/forgot_password.dart';
import 'package:nidful/screens/home.dart';
import 'package:nidful/screens/register.dart';
import 'package:nidful/utils/utils.dart';
import 'package:nidful/widgets/bottom_bar.dart';
import 'package:nidful/widgets/color_button.dart';
import 'package:nidful/widgets/input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethod().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Get.offAll(() => BottomBar());
    }
    setState(() {
      _isLoading = false;
    });
  }

  _showanimation(BuildContext context, animation) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Lottie.asset(
                animation,
                width: 100,
                height: 100,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.height;
    ScreenUtil().setSp(16);
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2.5,
            child: Stack(
              // fit: StackFit.expand,
              overflow: Overflow.visible,
              children: [
                Positioned(
                  top: -60,
                  right: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
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
          // Expanded(child: Container()),
          SizedBox(
            height: MediaQuery.of(context).size.height / 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sign In',
                  style: GoogleFonts.workSans(
                      color: Colors.black,
                      fontSize: 23.sp,
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
                      onTap: loginUser,
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
                                  'Login',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => RegisterPage());
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account? ',
                          style: GoogleFonts.workSans(
                            color: Colors.black,
                            fontSize: 16.sp,
                          ),
                          children: [
                            TextSpan(
                              text: 'Register',
                              style: GoogleFonts.workSans(
                                // fontSize: 10,
                                fontSize: 10,
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => ForgotPasswordPage());
                      },
                      child: RichText(
                          text: TextSpan(
                        text: 'Forgot Password ',
                        style: GoogleFonts.workSans(
                          color: Colors.black,
                          // fontSize: 10,
                          fontSize: 10,
                        ),
                      )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
