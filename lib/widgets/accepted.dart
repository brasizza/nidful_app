// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/models/user.dart' as model;
import 'package:nidful/providers/user_provider.dart';
import 'package:nidful/resources/firestore_methods.dart';
import 'package:nidful/screens/detail_page.dart';
import 'package:nidful/screens/profile_page.dart';
import 'package:nidful/utils/utils.dart';
import 'package:nidful/widgets/circle_icon.dart';
import 'package:provider/provider.dart';

class AcceptedList extends StatefulWidget {
  final snap;
  const AcceptedList({Key? key, this.snap}) : super(key: key);

  @override
  State<AcceptedList> createState() => _AcceptedListState();
}

class _AcceptedListState extends State<AcceptedList> {
  var data;
  @override
  void initState() {
    super.initState();
    getProduct();
  }

  void getProduct() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('products')
        .doc(widget.snap['postId'])
        .get();
    setState(() {
      data = snap.data();
    });
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(children: [
            CircleIcon(
              icon: Icons.notifications_outlined,
              iconSize: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.snap['status'] == 'accepted')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Comrade 🌟',
                        style: GoogleFonts.workSans(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        "${widget.snap['username']} accepted your request for a product",
                        style: GoogleFonts.workSans(fontSize: 10),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      // Row(
                      //   children: [
                      //     InkWell(
                      //       onTap: () async {
                      //         String res = await FireStoreMethods().acceptVet(
                      //           postId: widget.snap['postId'],
                      //         );
                      //         if (res != 'success') {
                      //           showSnackBar(res, context);
                      //         } else {
                      //           // await FireStoreMethods().acceptedVet(
                      //           //     postId: widget.snap['postId'],
                      //           //     username: user.username,
                      //           //     requester: widget.snap['receiver']);
                      //           showSnackBar('Accepted', context);
                      //           Get.to(
                      //             () => ProfilePage(uid: widget.snap['sender']),
                      //           );
                      //         }
                      //       },
                      //       child: Container(
                      //         width: 100,
                      //         height: 30,
                      //         decoration: BoxDecoration(
                      //           color: Colors.green,
                      //           borderRadius: BorderRadius.circular(5),
                      //         ),
                      //         child: Center(
                      //           child: Text(
                      //             'Accept',
                      //             style: TextStyle(color: Colors.white),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 30,
                      //     ),
                      //     Container(
                      //       width: 100,
                      //       height: 30,
                      //       decoration: BoxDecoration(
                      //         color: Colors.red,
                      //         borderRadius: BorderRadius.circular(5),
                      //       ),
                      //       child: Center(
                      //         child: Text(
                      //           'Reject',
                      //           style: TextStyle(color: Colors.white),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  )
                else if (widget.snap['type'] == 'accepted')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lucky Comrade 🌟',
                        style: GoogleFonts.workSans(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        '${widget.snap['username']} wants to gift you macbook',
                        style: GoogleFonts.workSans(fontSize: 10),
                      ),
                    ],
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Comrade 🌟',
                        style: GoogleFonts.workSans(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        'John wants to gift you macbook',
                        style: GoogleFonts.workSans(fontSize: 10),
                      ),
                    ],
                  ),
              ],
            ),
          ]),
        ),
        InkWell(
            onTap: () {
              Get.to(DetailPage(
                snap: data,
              ));
            },
            child: Icon(Icons.arrow_forward_outlined)),
      ],
    );
  }
}
