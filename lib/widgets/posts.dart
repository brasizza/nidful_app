// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nidful/models/user.dart';
import 'package:nidful/providers/user_provider.dart';
import 'package:nidful/resources/firestore_methods.dart';
import 'package:nidful/screens/detail_page.dart';
import 'package:nidful/screens/profile_page.dart';
import 'package:nidful/widgets/follow_button.dart';
import 'package:nidful/widgets/like_animation.dart';
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
  bool isLikeAnimating = false;
  var color = Colors.white;
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
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
                  widget.snap['postId'], user.uid, widget.snap['likes']);
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.snap['postUrl'],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1.0 : 0.0,
                  child: LikeAnimation(
                    child: Lottie.asset('assets/like.json'),
                    // child: const Icon(
                    //   Icons.thumb_up,
                    //   color: Colors.white,
                    //   size: 100,
                    // ),
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
                          widget.snap['profImage'] == ''
                              ? CircleAvatar(
                                  radius: 16,
                                  backgroundImage: AssetImage(
                                    'assets/user2.png',
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 16,
                                  backgroundImage: NetworkImage(
                                    widget.snap['profImage'],
                                  ),
                                ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.snap['username'],
                                style:
                                    GoogleFonts.workSans(color: Colors.white),
                              ),
                              Text(
                                'We rise by lifting others',
                                style:
                                    GoogleFonts.workSans(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    FollowButton(
                      label: 'Following',
                      buttonColor: Colors.white,
                      textColor: Colors.black,
                    )
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
                          style: GoogleFonts.workSans(color: Colors.white),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.snap['description'],
                          style: GoogleFonts.workSans(color: Colors.grey),
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
                                      widget.snap['likes']);
                                },
                                child: SvgPicture.asset(
                                  'assets/LIKE.svg',
                                  width: 20,
                                  height: 20,
                                  color: widget.snap['likes'].contains(user.uid)
                                      ? Colors.red
                                      : Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              widget.snap['likes'].length.toString(),
                              style: GoogleFonts.workSans(color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(width: 15),
                        SvgPicture.asset(
                          'assets/SHARE.svg',
                          width: 20,
                          height: 20,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    SvgPicture.asset(
                      'assets/BOOKMARK.svg',
                      width: 20,
                      height: 20,
                      color: Colors.black,
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
