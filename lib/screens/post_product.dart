// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/widgets/color_button.dart';
import 'package:nidful/widgets/input_field.dart';

class PostProduct extends StatefulWidget {
  const PostProduct({Key? key}) : super(key: key);

  @override
  State<PostProduct> createState() => _PostProductState();
}

class _PostProductState extends State<PostProduct> {
  @override
  Widget build(BuildContext context) {
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
          "Make a post",
          style: GoogleFonts.workSans(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  InputWidget(
                    label: 'What item are you giving out?',
                    hint: 'Macbook Pro',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                    ),
                    child: Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InputWidget(
                    label: 'Select Category',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InputWidget(
                    label: 'Product Condition',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InputWidget(
                    label: 'Quantity',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InputWidget(
                    label: 'Item Description',
                    height: 150,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Button(
                    label: 'Post',
                    height: 60,
                    width: 400,
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
