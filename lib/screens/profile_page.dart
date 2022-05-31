// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/constant/constants.dart';
import 'package:nidful/resources/firestore_methods.dart';
import 'package:nidful/screens/detail_page.dart';
import 'package:nidful/screens/edit_profile.dart';
import 'package:nidful/screens/post_product.dart';
import 'package:nidful/screens/settings.dart';
import 'package:nidful/utils/utils.dart';
import 'package:nidful/widgets/color_button.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  const ProfilePage({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var userData = {};
  int productLength = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      // get Product length
      var postSnap = await FirebaseFirestore.instance
          .collection('products')
          .where('uid', isEqualTo: widget.uid)
          .get();
      productLength = postSnap.docs.length;
      userData = userSnap.data()!;
      userData = userSnap.data()!;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
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
                FirebaseAuth.instance.currentUser!.uid == widget.uid
                    ? "${userData['firstname'] != '' ? userData['firstname'] : 'Please fill your profile'} ${userData['lastname'] ?? ''}"
                    : '',
                style: GoogleFonts.workSans(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: userData['firstname'] != '' ? 20 : 16,
                ),
              ),
              actions: [
                Row(
                  children: [
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
                    IconButton(
                      icon: Icon(
                        Icons.logout,
                        color: Colors.black,
                        size: 20,
                      ),
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                    ),
                  ],
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
                        userData['photoUrl'] == ''
                            ? CircleAvatar(
                                minRadius: 50,
                                maxRadius: 50,
                                backgroundImage:
                                    AssetImage('assets/profile_image.png'),
                              )
                            : CircleAvatar(
                                minRadius: 50,
                                maxRadius: 50,
                                backgroundImage:
                                    NetworkImage(userData['photoUrl']),
                              ),
                        SizedBox(height: 20),
                        Text(
                          userData['username'] ?? '',
                          style: GoogleFonts.workSans(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          userData['bio'] != ""
                              ? userData['bio']
                              : 'Add bio in your profile',
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
                                  following.toString(),
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
                                  followers.toString(),
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
                                  productLength.toString(),
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
                            // Button(label: 'Message John', width: 150, height: 40),
                            FirebaseAuth.instance.currentUser!.uid == widget.uid
                                ? Button(
                                    label: 'Edit Profile',
                                    color: Colors.grey[300],
                                    textcolor: primaryColor,
                                    width: 150,
                                    height: 40,
                                    function: () {
                                      Get.to(() => Editprofile());
                                    },
                                  )
                                : isFollowing != true
                                    ? Button(
                                        label: 'Follow',
                                        load: Text(
                                          'Follow',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        color: primaryColor,
                                        textcolor: Colors.white,
                                        width: 150,
                                        height: 40,
                                        function: () async {
                                          await FireStoreMethods().followUser(
                                            FirebaseAuth
                                                .instance.currentUser!.uid,
                                            userData['uid'],
                                          );
                                          setState(() {
                                            isFollowing = true;
                                            followers++;
                                          });
                                        },
                                      )
                                    : Button(
                                        label: 'Unfollow',
                                        color: Colors.grey[300],
                                        textcolor: primaryColor,
                                        width: 150,
                                        height: 40,
                                        function: () async {
                                          await FireStoreMethods().followUser(
                                            FirebaseAuth
                                                .instance.currentUser!.uid,
                                            userData['uid'],
                                          );
                                          setState(() {
                                            isFollowing = false;
                                            followers--;
                                          });
                                        },
                                      ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection('products')
                                .where('uid', isEqualTo: widget.uid)
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              return StaggeredGridView.countBuilder(
                                scrollDirection: Axis.vertical,
                                physics: ScrollPhysics(),
                                itemCount:
                                    (snapshot.data! as dynamic).docs.length,
                                shrinkWrap: true,
                                crossAxisCount: 3,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 16,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot snap =
                                      (snapshot.data! as dynamic).docs[index];
                                  return InkWell(
                                    onTap: () => DetailPage(snap: snap),
                                    child: Container(
                                      width: 200,
                                      height: 108,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: Image.network(
                                            snap['postUrl'],
                                            fit: BoxFit.cover,
                                          ).image,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                staggeredTileBuilder: (int index) =>
                                    StaggeredTile.fit(1),
                              );
                            },
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
