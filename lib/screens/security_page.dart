// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nidful/models/user.dart' as model;
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/providers/user_provider.dart';
import 'package:nidful/widgets/color_button.dart';
import 'package:nidful/widgets/input_field.dart';
import 'package:provider/provider.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({Key? key}) : super(key: key);

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        title: Text(
          "Security",
          style: GoogleFonts.workSans(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      InputWidget(
                        controller: _passwordController,
                        label: 'Password',
                        isObscure: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InputWidget(
                        controller: _confirmPasswordController,
                        label: 'Confirm password',
                        isObscure: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Button(
                        function: () async {
                          setState(() {
                            isLoading = true;
                          });
                          if (_passwordController.text !=
                              _confirmPasswordController.text) {
                            setState(() {
                              isLoading = false;
                            });
                            Get.snackbar('Error', 'Passwords do not match',
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                          } else {
                            // change password
                            await FirebaseAuth.instance.currentUser!
                                .updatePassword(_passwordController.text);
                            // reauthenticate user
                            await FirebaseAuth.instance.currentUser!
                                .reauthenticateWithCredential(
                                    EmailAuthProvider.credential(
                                        email: user.email,
                                        password: _passwordController.text));
                            setState(() {
                              isLoading = false;
                            });
                            Get.snackbar(
                                'Success', 'Password changed successfully',
                                backgroundColor: Colors.green,
                                colorText: Colors.white);
                          }
                        },
                        label: 'Change Password',
                        load: isLoading
                            ? Center(child: CircularProgressIndicator())
                            : Text(
                                'Change Password',
                                style: GoogleFonts.workSans(
                                    fontSize: 25.sp, color: Colors.white),
                              ),
                        width: 400,
                        height: 60,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
