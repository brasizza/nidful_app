// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entry/entry.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/constant/constants.dart';
import 'package:nidful/models/user.dart' as model;
import 'package:nidful/providers/user_provider.dart';
import 'package:nidful/screens/cat_list.dart';
import 'package:nidful/screens/catt_list.dart';
import 'package:nidful/screens/message_lists.dart';
import 'package:nidful/screens/post_product.dart';
import 'package:nidful/service/not.dart';
import 'package:nidful/widgets/category_grid.dart';
import 'package:nidful/widgets/circle_icon.dart';
import 'package:nidful/widgets/input_field.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var catData = {};
  final TextEditingController searchController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  storeNotificationToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      print('Token: $token');
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({'token': token}, SetOptions(merge: true));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.display(event);
    });

    storeNotificationToken();
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;

    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Entry.all(
                  duration: Duration(seconds: 2),
                  child: Column(
                    children: [
                      // Appbar
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Hi ${user.username} 👋',
                                        style: GoogleFonts.workSans(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        'What are you giving out today?',
                                        style: GoogleFonts.workSans(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () =>
                                            Get.to(() => PostProduct()),
                                        child: CircleIcon(
                                            isSvg: true,
                                            icon: 'assets/PLUS.svg'),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Stack(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.to(() => MessageList());
                                            },
                                            child: CircleIcon(
                                              isSvg: true,
                                              icon: 'assets/MSG.svg',
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: Container(
                                              width: 13,
                                              height: 13,
                                              decoration: BoxDecoration(
                                                color: Color(0xffFF0000),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '2',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 8),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ]),
                            // Serchbar
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: InputWidget(
                                      controller: searchController,
                                      label: '',
                                      height: 50,
                                      hint: 'Search'),
                                ),
                                SizedBox(width: 7),
                                Column(
                                  children: [
                                    SizedBox(height: 16),
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(() => CatList(
                                              search: searchController.text,
                                            ));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: primaryColor,
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            'assets/FILTER.svg',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('categories')
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<
                                        QuerySnapshot<Map<String, dynamic>>>
                                    snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return StaggeredGridView.countBuilder(
                                physics: ScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                crossAxisSpacing: 13,
                                mainAxisSpacing: 16,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        InkWell(
                                  onTap: () {
                                    Get.to(() => CatLList(
                                          search: snapshot.data!.docs[index]
                                              .data()['cat_name'],
                                        ));
                                  },
                                  child: CategoryWidget(
                                    label: snapshot.data!.docs[index]
                                        .data()['cat_name'],
                                    image: snapshot.data!.docs[index]
                                        .data()['cat_img'],
                                  ),
                                ),
                                staggeredTileBuilder: (int index) =>
                                    StaggeredTile.fit(1),
                                // mainAxisSpacing: 4.0,
                                // crossAxisSpacing: 4.0,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
