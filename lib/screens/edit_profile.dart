// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nidful/models/user.dart' as model;
import 'package:nidful/providers/user_provider.dart';
import 'package:nidful/resources/firestore_methods.dart';
import 'package:nidful/utils/utils.dart';
import 'package:nidful/widgets/color_button.dart';
import 'package:nidful/widgets/input_field.dart';
import 'package:provider/provider.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({Key? key}) : super(key: key);

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  Uint8List? _file;
  bool isLoading = false;

  _selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('Add an image'),
          children: [
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Text('Take a photo'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(
                  ImageSource.camera,
                );
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Text('Choose from gallery'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(
                  ImageSource.gallery,
                );
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Text('Cancel'),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    final TextEditingController _firstnameController =
        TextEditingController(text: user.firstname);
    final TextEditingController _lastnameController =
        TextEditingController(text: user.lastname);
    final TextEditingController _usernameController =
        TextEditingController(text: user.username);
    final TextEditingController _emailController =
        TextEditingController(text: user.email);
    final TextEditingController _bioController =
        TextEditingController(text: user.bio);

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
          "Edit Profile",
          style: GoogleFonts.workSans(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2));
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: user.photoUrl == ''
                        ? GestureDetector(
                            onTap: () => _selectImage(context),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.transparent,
                              child: _file != null
                                  ? Image(
                                      image: MemoryImage(_file!),
                                    )
                                  : Icon(Icons.person),
                            ),
                          )
                        : GestureDetector(
                            onTap: () => _selectImage(context),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: _file != null
                                  ? Image(
                                      image: MemoryImage(_file!),
                                    ).image
                                  : NetworkImage(user.photoUrl),
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        InputWidget(
                          label: 'First Name',
                          controller: _firstnameController,
                          height: 50,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InputWidget(
                          label: 'Last Name',
                          controller: _lastnameController,
                          height: 50,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InputWidget(
                          label: 'Username',
                          controller: _usernameController,
                          height: 50,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InputWidget(
                          label: 'Email address',
                          controller: _emailController,
                          height: 50,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InputWidget(
                          label: 'Bio',
                          controller: _bioController,
                          height: 50,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Button(
                          label: isLoading ? '' : 'Update Info',
                          load: isLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  'Update Info',
                                  style: TextStyle(color: Colors.white),
                                ),
                          width: 400,
                          height: 60,
                          function: () async {
                            setState(() {
                              isLoading = true;
                            });
                            var res = await FireStoreMethods().updateuser(
                              _firstnameController.text,
                              _lastnameController.text,
                              _usernameController.text,
                              _emailController.text,
                              _bioController.text,
                              _file,
                            );
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
                              Get.snackbar(
                                'Success',
                                'Profile updated successfully',
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                                borderRadius: 10,
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(10),
                              );
                            }
                            setState(() {
                              isLoading = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
