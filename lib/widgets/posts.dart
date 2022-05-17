// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/widgets/follow_button.dart';

class Posts extends StatefulWidget {
  final String image;
  final String userProfileImage;
  final String name;
  final String label;
  final String likeCount;

  const Posts(
      {Key? key,
      required this.image,
      required this.userProfileImage,
      required this.name,
      required this.label,
      required this.likeCount})
      : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.asset(widget.image).image,
                fit: BoxFit.cover,
              ),
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
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(widget.userProfileImage),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: GoogleFonts.workSans(color: Colors.white),
                            ),
                            Text(
                              'We rise by lifting others',
                              style: GoogleFonts.workSans(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
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
                          widget.label,
                          style: GoogleFonts.workSans(color: Colors.white),
                        ),
                        Text(
                          'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto.',
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
                            Icon(Icons.thumb_up_off_alt_outlined,
                                color: Colors.white),
                            Text(
                              widget.likeCount,
                              style: GoogleFonts.workSans(color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(width: 15),
                        Icon(Icons.share_outlined, color: Colors.white),
                      ],
                    ),
                    Icon(Icons.bookmark_outline, color: Colors.white),
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
