// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/constant/constants.dart';
import 'package:nidful/screens/post_product.dart';
import 'package:nidful/screens/settings.dart';
import 'package:nidful/widgets/color_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
          "John Doe",
          style: GoogleFonts.workSans(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              Get.to(() => Settingpage());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: [
                  CircleAvatar(
                    minRadius: 50,
                    maxRadius: 50,
                    backgroundImage: AssetImage('assets/profile_image.png'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'John Doe',
                    style: GoogleFonts.workSans(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'We rise by lifting others! 30BG for life',
                    style: GoogleFonts.workSans(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            '409k',
                            style: GoogleFonts.workSans(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Following',
                            style: GoogleFonts.workSans(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '945k',
                            style: GoogleFonts.workSans(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Followers',
                            style: GoogleFonts.workSans(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '2.9M',
                            style: GoogleFonts.workSans(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Items Given',
                            style: GoogleFonts.workSans(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Button(label: 'Message John', width: 150, height: 40),
                      Button(
                          label: 'Follow',
                          color: Colors.grey[300],
                          textcolor: primaryColor,
                          width: 150,
                          height: 40),
                    ],
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: StaggeredGridView.countBuilder(
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      itemCount: 10,
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 16,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 200,
                          height: 108,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: Image.asset(
                                'assets/myproduct.png',
                                fit: BoxFit.cover,
                              ).image,
                            ),
                          ),
                        );
                      },
                      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => PostProduct());
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add_outlined),
      ),
    );
  }
}
