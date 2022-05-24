// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/widgets/follow_button.dart';

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
  var color = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                          widget.snap['title'],
                          style: GoogleFonts.workSans(color: Colors.white),
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
                            InkWell(
                              onDoubleTap: () {
                                setState(() {
                                  color = Colors.red;
                                });
                              },
                              child: Icon(Icons.thumb_up_off_alt_outlined,
                                  color: color),
                            ),
                            Text(
                              '10k',
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
