// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/models/user.dart' as model;
import 'package:nidful/providers/user_provider.dart';
import 'package:nidful/resources/firestore_methods.dart';
import 'package:nidful/screens/profile_page.dart';
import 'package:nidful/utils/utils.dart';
import 'package:nidful/widgets/follow_button.dart';
import 'package:provider/provider.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailPage extends StatefulWidget {
  final snap;

  const DetailPage({Key? key, required this.snap}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var userData = {};
  var posterData = {};
  var getterData = [];
  bool isFollowing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getPoster();
    getVetter();
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
      // print(posterData);
      isLoading = false;
    });
  }

  Future<List> getVetter() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('vets')
          .where('postId', isEqualTo: widget.snap['postId'])
          .get();
      List vetData = snap.docs.map((doc) => doc.data()).toList();
      if (vetData != null) {
        // get vet data
        vetData.forEach((f) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(f['requester'])
              .get()
              .then((doc) {
            if (doc.exists) {
              // print(followers.length);
              // followers = [...followers, doc.data()];
              getterData.add(doc.data());
              setState(() {
                getterData = getterData;
              });
              // pass followers
              // return followers;
            }
          });
        });
      }
    } catch (e) {
      print(e);
    }
    return getterData;
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

  bool isLoading = false;
  bool isLoadingReject = false;
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: ScrollAppBar(
              controller: controller,
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
                widget.snap['title'],
                style: GoogleFonts.workSans(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            body: Snap(
              controller: controller.appBar,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(() =>
                                      ProfilePage(uid: widget.snap['uid']));
                                },
                                child: posterData['photoUrl'] == ""
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
                                        backgroundImage: NetworkImage(
                                            posterData['photoUrl']),
                                      ),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    posterData['username'],
                                    style: GoogleFonts.workSans(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  // Text(
                                  //   'We rise by lifting others!',
                                  //   style: GoogleFonts.workSans(),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                          FirebaseAuth.instance.currentUser!.uid !=
                                  userData['uid']
                              ? isFollowing
                                  ? FollowButton(
                                      function: () async {
                                        await FireStoreMethods().followUser(
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                          userData['uid'],
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
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                          userData['uid'],
                                        );
                                        setState(() {
                                          isFollowing = true;
                                        });
                                      },
                                    )
                              : Container(),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04),
                      Center(
                        child: Column(
                          children: [
                            ClipRRect(
                              child: Image.network(
                                widget.snap['postUrl'],
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.57,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              await FireStoreMethods()
                                                  .likeProduct(
                                                widget.snap['postId'],
                                                user.uid,
                                                widget.snap['uid'],
                                                widget.snap['likes'],
                                                user.username,
                                                user.photoUrl,
                                                widget.snap['postUrl'],
                                              );
                                              // setState(() {
                                              //   widget.snap['likes'] = int.parse(
                                              //           widget.snap['likes'].length) +
                                              //       1;
                                              // });
                                            },
                                            child: SvgPicture.asset(
                                              'assets/LIKE.svg',
                                              color: widget.snap['likes']
                                                      .contains(
                                                          widget.snap['uid'])
                                                  ? Colors.red
                                                  : Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            '${widget.snap['likes'].length.toString()}',
                                            style: GoogleFonts.workSans(
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 15),
                                      SvgPicture.asset(
                                        'assets/SHARE.svg',
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  SvgPicture.asset(
                                    'assets/BOOKMARK.svg',
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.5),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.snap['title'],
                                style: GoogleFonts.workSans(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                widget.snap['description'],
                                style: GoogleFonts.workSans(
                                  fontSize: 14,
                                ),
                              ),
                            ]),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      // FutureBuilder(
                      //   future: getVetter(),
                      //   builder: (context, snapshot) {
                      //     if (snapshot.connectionState ==
                      //         ConnectionState.waiting) {
                      //       return Center(
                      //         child: CircularProgressIndicator(),
                      //       );
                      //     }
                      //     return
                      //   },
                      // ),
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: getterData.length,
                        itemBuilder: (context, snapshot) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    getterData[snapshot]['photoUrl'] == ''
                                        ? InkWell(
                                            onTap: () {
                                              Get.to(
                                                () => ProfilePage(
                                                  uid: (getterData[snapshot]
                                                      ['uid']),
                                                ),
                                              );
                                            },
                                            child: CircleAvatar(
                                              // minRadius: 50,
                                              // maxRadius: 50,
                                              // generate random background color
                                              backgroundColor: Colors.primaries[
                                                  Random().nextInt(
                                                      Colors.primaries.length)],
                                              child: Center(
                                                child: Text(
                                                  getterData[snapshot]
                                                          ['username']
                                                      .toUpperCase()
                                                      .substring(0, 1),
                                                  style: GoogleFonts.workSans(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 30,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () {
                                              Get.to(
                                                () => ProfilePage(
                                                    uid: getterData[snapshot]
                                                        ['uid']),
                                              );
                                            },
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  getterData[snapshot]
                                                      ['photoUrl']),
                                            ),
                                          ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                    Text(
                                      getterData[snapshot]['username'],
                                      style: GoogleFonts.workSans(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                FirebaseAuth.instance.currentUser!.uid ==
                                        widget.snap['uid']
                                    ? FollowButton(
                                        function: () async {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          String res = await FireStoreMethods()
                                              .itemPingAccept(
                                            postId: widget.snap['postId'],
                                            uid: user.uid,
                                            requester: getterData[snapshot]
                                                ['uid'],
                                            username: getterData[snapshot]
                                                ['username'],
                                            giver: user.username,
                                          );
                                          setState(() {
                                            isLoading = false;
                                          });
                                          if (res != 'success') {
                                            Get.snackbar(
                                              'Success',
                                              res,
                                              backgroundColor: Colors.red,
                                              colorText: Colors.white,
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              borderRadius: 10,
                                              margin: EdgeInsets.all(10),
                                              padding: EdgeInsets.all(10),
                                            );
                                          } else {
                                            // showSnackBar(
                                            //     'Request has been sent',
                                            //     context);
                                            Get.snackbar(
                                              'Success',
                                              'Request sent to ${getterData[snapshot]['username']}',
                                              backgroundColor: Colors.green,
                                              colorText: Colors.white,
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              borderRadius: 10,
                                              margin: EdgeInsets.all(10),
                                              padding: EdgeInsets.all(10),
                                            );
                                          }
                                        },
                                        label: isLoading
                                            ? 'Sending......'
                                            : 'Give Item',
                                      )
                                    : FollowButton(
                                        label: 'Requested',
                                      ),
                              ],
                            ),
                          );
                        },
                      ),
                      // );
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
