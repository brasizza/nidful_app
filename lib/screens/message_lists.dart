// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/screens/chat_page.dart';
// import 'package:nidful/widgets/messages.dart';
import 'package:intl/intl.dart';

class MessageList extends StatelessWidget {
  const MessageList({Key? key}) : super(key: key);

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
          "Messages",
          style: GoogleFonts.workSans(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('messages')
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.docs.length < 1) {
              return Center(
                child: Text('No chat available'),
              );
            }

            return ListView.builder(
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                var friendId = snapshot.data.docs[index].id;
                var lastMsg = snapshot.data.docs[index]['last_message'];
                var date = snapshot.data.docs[index]['time'];
                var read = snapshot.data.docs[index]['read'];
                return FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(friendId)
                      .get(),
                  builder: (context, AsyncSnapshot asyncSnapshot) {
                    if (asyncSnapshot.hasData) {
                      var friend = asyncSnapshot.data;
                      return ListTile(
                        leading: friend['photoUrl'] != ''
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Image.network(
                                    friend['photoUrl'],
                                    // fit: BoxFit.fill,
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                child: Text(
                                  friend['email'].substring(0, 1),
                                  style: GoogleFonts.workSans(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                        title: Text(friend['username']),
                        subtitle: Container(
                          child: Text(
                            '$lastMsg',
                            style: GoogleFonts.workSans(
                                color: Colors.black, fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        trailing: read == false
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${DateFormat.Hms().format(date.toDate())}',
                                    style: GoogleFonts.workSans(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Container(
                                        height: 16,
                                        width: 16,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '1',
                                            style: GoogleFonts.workSans(
                                                color: Colors.white),
                                          ),
                                        ),
                                      )),
                                ],
                              )
                            : Container(
                                child: Text(
                                  '${DateFormat.Hms().format(date.toDate())}',
                                  style: GoogleFonts.workSans(
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                        onTap: () async {
                          if (friend['uid'] !=
                              FirebaseAuth.instance.currentUser!.uid) {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection('messages')
                                .doc(friendId)
                                .update({
                              'read': true,
                            });
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(friendId)
                                .collection('messages')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .update({
                              'read': true,
                            });
                          }
                          Get.to(
                            () => ChatPage(
                              receiver: friend['uid'],
                            ),
                          );
                        },
                      );
                    }

                    return LinearProgressIndicator();
                  },
                );
              },
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
