// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
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
                controller: _emailController,
                label: 'Email Address',
                hint: 'johndoe@email.com',
              ),
              SizedBox(
                height: 16,
              ),
              InputWidget(
                controller: _passwordController,
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
                  child: InkWell(
                    onTap: loginUser,
                    child: Container(
                      width: double.infinity,
                      height: 50,
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
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                InkWell(
                  onTap: () {
                    Get.to(() => RegisterPage());
                  },
                  child: RichText(
                      text: TextSpan(
                    text: 'Don\'t have an account? ',
                    style:
                        GoogleFonts.workSans(color: Colors.black, fontSize: 10),
                    children: [
                      TextSpan(
                        text: 'Register',
                        style: GoogleFonts.workSans(
                          fontSize: 10,
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
                    style:
                        GoogleFonts.workSans(color: Colors.black, fontSize: 10),
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
