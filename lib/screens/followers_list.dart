// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/controllers/followers.dart';
import 'package:nidful/widgets/followers_list_item.dart';
import 'package:nidful/widgets/following_list_item.dart';

class FollowerList extends StatefulWidget {
  final uid;

  const FollowerList({Key? key, this.uid}) : super(key: key);

  @override
  State<FollowerList> createState() => _FollowerListState();
}

class _FollowerListState extends State<FollowerList> {
  final FollowersController followersController =
      Get.put(FollowersController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    followersController.getFollowers(widget.uid);
  }

  // filter the list of followers
  filterFollowers(String query) {
    List<dynamic> filteredFollowers = [];
    if (query.isNotEmpty) {
      filteredFollowers = followersController.followers.value
          .where(
              (f) => f['username'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      filteredFollowers = followersController.followers.value;
    }
    return filteredFollowers;
  }

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
          "Followers",
          style: GoogleFonts.workSans(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              child: TextField(
                onChanged: (query) {
                  setState(() {
                    followersController.followers.value =
                        filterFollowers(query);
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintText: "Search",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            // Obx(
            //   () {
            //     return FutureBuilder(
            //       // get following list by uid
            //       future: followersController.getFollowing(widget.uid),
            //       builder: (context, AsyncSnapshot snapshot) {
            //         if (snapshot.connectionState == ConnectionState.waiting) {
            //           return Center(
            //             child: CircularProgressIndicator(),
            //           );
            //         }
            //         return ListView.builder(
            //           shrinkWrap: true,
            //           itemCount: snapshot.data!.length,
            //           itemBuilder: (context, index) {
            //             // return following list
            //             return FollowingListItem(
            //               followingList: snapshot.data![index],
            //             );
            //           },
            //         );
            //       },
            //     );
            //   },
            // ),
            // return obx
            Obx(() {
              final snapshot = followersController.followers.value;
              if (snapshot.isEmpty) {
                return Center(
                  child: Text("You currently have no followers"),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.length,
                itemBuilder: (context, index) {
                  // return following list
                  return FollowersListItem(
                    userid: widget.uid,
                    followingList: snapshot[index],
                  );
                },
              );
            })
          ]),
        ),
      ),
    );
  }
}
