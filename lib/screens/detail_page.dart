// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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

class DetailPage extends StatefulWidget {
  final snap;

  const DetailPage({Key? key, required this.snap}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
                          child: CircleAvatar(
                            backgroundImage:
                                Image.asset('assets/user.png').image,
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.snap['username'],
                              style: GoogleFonts.workSans(
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'We rise by lifting others!',
                              style: GoogleFonts.workSans(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    FollowButton(),
                  ],
                ),
                SizedBox(height: 30),
                Center(
                  child: Column(
                    children: [
                      ClipRRect(
                        child: Image.network(widget.snap['postUrl']),
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
                                      },
                                      child: Icon(
                                        Icons.thumb_up,
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
                                Icon(Icons.share_outlined),
                              ],
                            ),
                            Icon(Icons.bookmark_outline),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
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
                SizedBox(height: 25),
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
                                              .itemPingPend(
                                            postId: widget.snap['postId'],
                                            uid: widget.snap['uid'],
                                            requester: FirebaseAuth
                                                .instance.currentUser!.uid,
                                            username: user.username,
                                          );
                                          setState(() {
                                            isLoading = false;
                                          });
                                          if (res != 'success') {
                                            showSnackBar(res, context);
                                          } else {
                                            showSnackBar(
                                                'Request has been sent',
                                                context);
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
                                    Image.asset('assets/user2.png'),
                                    SizedBox(width: 10),
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
