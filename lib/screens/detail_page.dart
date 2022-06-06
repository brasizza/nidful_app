// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

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
  bool isFollowing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
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
    return Scaffold(
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
                            Get.to(() => ProfilePage(uid: widget.snap['uid']));
                          },
                          child: widget.snap['profImage'] == ""
                              ? CircleAvatar(
                                  backgroundImage:
                                      Image.asset('assets/user.png').image,
                                )
                              : CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(widget.snap['profImage']),
                                ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.snap['username'],
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
                    FirebaseAuth.instance.currentUser!.uid != userData['uid']
                        ? isFollowing
                            ? FollowButton(
                                function: () async {
                                  await FireStoreMethods().followUser(
                                    FirebaseAuth.instance.currentUser!.uid,
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
                                    FirebaseAuth.instance.currentUser!.uid,
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Center(
                  child: Column(
                    children: [
                      ClipRRect(
                        child: Image.network(
                          widget.snap['postUrl'],
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.57,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      SizedBox(height: 20),
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
                                    GestureDetector(
                                      onTap: () async {
                                        await FireStoreMethods().likeProduct(
                                            widget.snap['postId'],
                                            widget.snap['uid'],
                                            widget.snap['likes']);
                                        // setState(() {
                                        //   widget.snap['likes'] = int.parse(
                                        //           widget.snap['likes'].length) +
                                        //       1;
                                        // });
                                      },
                                      child: SvgPicture.asset(
                                        'assets/LIKE.svg',
                                        color: widget.snap['likes']
                                                .contains(widget.snap['uid'])
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('vets')
                      .where('postId', isEqualTo: widget.snap['postId'])
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Slidable(
                            endActionPane: ActionPane(
                              motion: StretchMotion(),
                              children: [
                                FirebaseAuth.instance.currentUser!.uid ==
                                        widget.snap['uid']
                                    ? SlidableAction(
                                        onPressed: ((context) async {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          String res = await FireStoreMethods()
                                              .itemPingAccept(
                                            postId: widget.snap['postId'],
                                            uid: widget.snap['uid'],
                                            requester: FirebaseAuth
                                                .instance.currentUser!.uid,
                                            username: user.username,
                                            giver: widget.snap['username'],
                                          );
                                          setState(() {
                                            isLoading = false;
                                          });
                                          if (res != 'success') {
                                            showSnackBar(res, context);
                                          } else {
                                            // showSnackBar(
                                            //     'Request has been sent',
                                            //     context);
                                            Fluttertoast.showToast(
                                                msg: 'Request has been sent',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.black,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          }
                                        }),
                                        backgroundColor: Colors.greenAccent,
                                        label:
                                            isLoading ? 'Sending.....' : 'Give',
                                      )
                                    : Text(''),
                                FirebaseAuth.instance.currentUser!.uid ==
                                        widget.snap['uid']
                                    ? SlidableAction(
                                        onPressed: ((context) async {
                                          setState(() {
                                            isLoadingReject = true;
                                          });
                                          await FireStoreMethods()
                                              .itemPingReject(
                                            postId: widget.snap['postId'],
                                            uid: widget.snap['uid'],
                                            requester: FirebaseAuth
                                                .instance.currentUser!.uid,
                                            username: user.username,
                                            giver: widget.snap['username'],
                                          );
                                          showSnackBar(
                                              'Request rejected', context);
                                          setState(() {
                                            isLoadingReject = false;
                                          });
                                        }),
                                        backgroundColor: Colors.redAccent,
                                        label: isLoadingReject
                                            ? 'Sending...'
                                            : 'Reject',
                                      )
                                    : Text(''),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    (snapshot.data! as dynamic).docs[index]
                                                ['photoUrl'] ==
                                            ''
                                        ? InkWell(
                                            onTap: () {
                                              Get.to(
                                                () => ProfilePage(
                                                    uid: (snapshot.data!
                                                                as dynamic)
                                                            .docs[index]
                                                        ['requester']),
                                              );
                                            },
                                            child: CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  'assets/user2.png'),
                                            ),
                                          )
                                        : CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                (snapshot.data! as dynamic)
                                                    .docs[index]['photoUrl']),
                                          ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                    Text(
                                      (snapshot.data! as dynamic).docs[index]
                                          ['username'],
                                      style: GoogleFonts.workSans(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                FollowButton(label: 'Requested'),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
