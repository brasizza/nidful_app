// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/widgets/follow_button.dart';

class Post1 extends StatefulWidget {
  const Post1({Key? key}) : super(key: key);

  @override
  State<Post1> createState() => _Post1State();
}

class _Post1State extends State<Post1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.asset('assets/tik.png').image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            alignment: Alignment(-1, 1),
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/user.png'),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'John Doe',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'We rise by lifting others',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        FollowButton(
                            label: 'Following',
                            buttonColor: Colors.white,
                            textColor: Colors.black)
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 62.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Giving out a MacBook Pro Air',
                            style: GoogleFonts.workSans(
                                fontSize: 14, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
                                  Icon(Icons.thumb_up_off_alt_outlined,
                                      color: Colors.white),
                                  Text(
                                    '901k',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              SizedBox(width: 15),
                              Icon(Icons.share_outlined, color: Colors.white),
                            ],
                          ),
                          SizedBox(width: 250),
                          Icon(Icons.bookmark_outline, color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
