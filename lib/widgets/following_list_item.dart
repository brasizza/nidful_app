// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/resources/firestore_methods.dart';
import 'package:nidful/screens/profile_page.dart';
import 'package:nidful/widgets/follow_button.dart';

class FollowingListItem extends StatefulWidget {
  final followingList;
  final userid;
  const FollowingListItem({Key? key, this.followingList, this.userid})
      : super(key: key);

  @override
  State<FollowingListItem> createState() => _FollowingListItemState();
}

class _FollowingListItemState extends State<FollowingListItem> {
  bool isFollowing = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () => Get.to(ProfilePage(uid: widget.followingList['uid'])),
        child: Row(
          children: [
            widget.followingList['photoUrl'] == ''
                ? CircleAvatar(
                    minRadius: 30,
                    backgroundColor: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)],
                    child: Text(
                      widget.followingList['username'][0].toUpperCase(),
                      style: GoogleFonts.workSans(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ))
                : CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        NetworkImage(widget.followingList['photoUrl']),
                  ),
            SizedBox(width: 10),
            Text(
              widget.followingList['username'],
              style: GoogleFonts.workSans(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Spacer(),
            FirebaseAuth.instance.currentUser!.uid == widget.userid
                ? isFollowing
                    ? FollowButton(
                        function: () async {
                          await FireStoreMethods().followUser(
                            FirebaseAuth.instance.currentUser!.uid,
                            widget.followingList['uid'],
                          );
                          setState(() {
                            isFollowing = false;
                          });
                        },
                        label: 'Following',
                      )
                    : FollowButton(
                        label: 'Follow',
                        function: () async {
                          await FireStoreMethods().followUser(
                            FirebaseAuth.instance.currentUser!.uid,
                            widget.followingList['uid'],
                          );
                          setState(() {
                            isFollowing = true;
                          });
                        },
                      )
                : Container(),
          ],
        ),
      ),
    );
  }
}
