// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/screens/profile_page.dart';
import 'package:nidful/widgets/follow_button.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class DetailPage extends StatefulWidget {
  final String title;

  const DetailPage({Key? key, required this.title}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
        controller: controller,
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
          widget.title,
          style: GoogleFonts.workSans(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Snap(
        controller: controller.appBar,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => ProfilePage());
                          },
                          child: CircleAvatar(
                            backgroundImage:
                                Image.asset('assets/user.png').image,
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'John Doe',
                              style: GoogleFonts.workSans(
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'We rise by lifting others!',
                              style: GoogleFonts.workSans(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    FollowButton(),
                  ],
                ),
                SizedBox(height: 30),
                Center(
                  child: Column(
                    children: [
                      Image.asset('assets/p.png'),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Icon(Icons.thumb_up_off_alt_outlined),
                                    Text('901k'),
                                  ],
                                ),
                                SizedBox(width: 15),
                                Icon(Icons.share_outlined),
                              ],
                            ),
                            Icon(Icons.bookmark_outline),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.5),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Giving out a Macbook air pro',
                          style: GoogleFonts.workSans(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto.',
                          style: GoogleFonts.workSans(
                            fontSize: 14,
                          ),
                        ),
                      ]),
                ),
                SizedBox(height: 25),
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Slidable(
                          endActionPane: ActionPane(
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: ((context) {}),
                                backgroundColor: Colors.greenAccent,
                                label: 'Give',
                              ),
                              SlidableAction(
                                onPressed: ((context) {}),
                                backgroundColor: Colors.redAccent,
                                label: 'Reject',
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset('assets/user2.png'),
                                  SizedBox(width: 10),
                                  Text(
                                    'Sammy Kelly',
                                    style: GoogleFonts.workSans(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              FollowButton(label: 'Requested'),
                            ],
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
