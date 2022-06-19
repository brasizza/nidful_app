// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_final_fields

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nidful/constant/constants.dart';
import 'package:nidful/models/user.dart' as model;
import 'package:nidful/providers/user_provider.dart';
import 'package:nidful/resources/firestore_methods.dart';
import 'package:nidful/screens/detail_page.dart';
import 'package:nidful/screens/profile_page.dart';
import 'package:nidful/utils/utils.dart';
import 'package:nidful/widgets/color_button.dart';
import 'package:nidful/widgets/follow_button.dart';
import 'package:nidful/widgets/like_animation.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

class Posts extends StatefulWidget {
  final snap;

  const Posts({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  var userData = {};
  var posterData = {};
  var isLoading = false;
  bool isLikeAnimating = false;
  bool isFollowing = false;
  var color = Colors.white;
  bool isSent = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    _updatePalletes();
    getPoster();
    getIfVet();
  }

  getPoster() async {
    setState(() {
      isLoading = true;
    });
    var userSnap = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.snap['uid'])
        .get();
    // return userSnap.data()!;
    setState(() {
      posterData = userSnap.data()!;
      isLoading = false;
    });
  }

  _updatePalletes() async {
    final PaletteGenerator generator = await PaletteGenerator.fromImageProvider(
      NetworkImage(widget.snap['postUrl']),
      size: Size(200, 200),
    );
    setState(() {
      color = generator.dominantColor?.color ?? Colors.black;
    });
  }

  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.snap['uid'])
          .get();

      userData = userSnap.data()!;
      userData = userSnap.data()!;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  getIfVet() async {
    try {
      var vetSnap = await FirebaseFirestore.instance
          .collection('vets')
          .where('requester', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('postId', isEqualTo: widget.snap['postId'])
          .get();
      if (vetSnap.docs.isNotEmpty) {
        setState(() {
          isSent = true;
        });
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;

    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          )
        : Scaffold(
            body: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => DetailPage(
                          snap: widget.snap,
                        ));
                  },
                  onDoubleTap: () async {
                    await FireStoreMethods().likeProduct(
                      widget.snap['postId'],
                      user.uid,
                      widget.snap['uid'],
                      widget.snap['likes'],
                      user.username,
                      user.photoUrl,
                      widget.snap['postUrl'],
                    );
                    setState(() {
                      isLikeAnimating = true;
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        // color: Colors.white,
                        decoration: BoxDecoration(),
                        child: PhotoView(
                          backgroundDecoration: BoxDecoration(
                            color: color,
                          ),
                          imageProvider: NetworkImage(
                            widget.snap['postUrl'],
                          ),
                        ),
                      ),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: isLikeAnimating ? 1.0 : 0.0,
                        child: LikeAnimation(
                          // child: Lottie.asset('assets/like.json'),
                          child: const Icon(
                            Icons.thumb_up,
                            color: Colors.white,
                            size: 100,
                          ),
                          isAnimating: isLikeAnimating,
                          duration: const Duration(milliseconds: 400),
                          onEnd: () {
                            setState(() {
                              isLikeAnimating = false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                () => ProfilePage(
                                  uid: widget.snap['uid'],
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                posterData['photoUrl'] == ''
                                    ? CircleAvatar(
                                        // minRadius: 50,
                                        // maxRadius: 50,
                                        // generate random background color
                                        backgroundColor: Colors.primaries[
                                            Random().nextInt(
                                                Colors.primaries.length)],
                                        child: Center(
                                          child: Text(
                                            posterData['username']
                                                .toUpperCase()
                                                .substring(0, 1),
                                            style: GoogleFonts.workSans(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 30,
                                            ),
                                          ),
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 16,
                                        backgroundImage: NetworkImage(
                                          posterData['photoUrl'],
                                        ),
                                      ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      posterData['username'],
                                      style: GoogleFonts.workSans(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    // Text(
                                    //   'We rise by lifting others',
                                    //   style:
                                    //       GoogleFonts.workSans(color: Colors.black),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          isSent
                              ? Button(
                                  label: 'Requested',
                                  fontsize: 16,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  textcolor: Colors.white,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                )
                              : Button(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  label: 'Get Item',
                                  load: isLoading
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      : Text(
                                          'Get Item',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  function: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    String res =
                                        await FireStoreMethods().getItem(
                                      postId: widget.snap['postId'],
                                      uid: widget.snap['uid'],
                                      requester: FirebaseAuth
                                          .instance.currentUser!.uid,
                                      username: user.username,
                                      photoUrl: user.photoUrl,
                                      title: widget.snap['title'],
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
                                      // print(res);
                                    } else {
                                      Get.snackbar(
                                        'Success',
                                        'Request has been sent',
                                        backgroundColor: Colors.green,
                                        colorText: Colors.white,
                                        snackPosition: SnackPosition.BOTTOM,
                                        borderRadius: 10,
                                        margin: EdgeInsets.all(10),
                                        padding: EdgeInsets.all(10),
                                      );
                                      setState(() {
                                        isSent = true;
                                      });
                                      // showSnackBar('Request has been sent', context);
                                    }
                                    setState(() {
                                      isLoading = false;
                                    });
                                  },
                                ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.snap['title'],
                                style: GoogleFonts.workSans(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                widget.snap['description'],
                                style: GoogleFonts.workSans(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ]),
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  LikeAnimation(
                                    isAnimating:
                                        widget.snap['likes'].contains(user.uid),
                                    smallLike: true,
                                    child: InkWell(
                                      onTap: () async {
                                        await FireStoreMethods().likeProduct(
                                          widget.snap['postId'],
                                          user.uid,
                                          widget.snap['uid'],
                                          widget.snap['likes'],
                                          user.username,
                                          user.photoUrl,
                                          widget.snap['postUrl'],
                                        );
                                      },
                                      child: SvgPicture.asset(
                                        'assets/LIKE.svg',
                                        width: 20,
                                        height: 20,
                                        color: widget.snap['likes']
                                                .contains(user.uid)
                                            ? Colors.red
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    widget.snap['likes'].length.toString(),
                                    style: GoogleFonts.workSans(
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              SizedBox(width: 15),
                              SvgPicture.asset(
                                'assets/SHARE.svg',
                                width: 20,
                                height: 20,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          SvgPicture.asset(
                            'assets/BOOKMARK.svg',
                            width: 20,
                            height: 20,
                            color: Colors.white24,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
