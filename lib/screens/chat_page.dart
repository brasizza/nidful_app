// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/constant/constants.dart';
import 'package:nidful/models/chatMessageModel.dart';
import 'package:nidful/models/user.dart' as model;
import 'package:nidful/providers/user_provider.dart';
import 'package:nidful/widgets/single_message.dart';
import 'package:provider/provider.dart';
// import 'package:nidful/widgets/bottom_bar.dart';

class ChatPage extends StatefulWidget {
  final receiver;

  const ChatPage({Key? key, required this.receiver}) : super(key: key);
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var data;
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textEditingController.dispose();
  }

  void getProfile() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.receiver)
        .get();
    setState(() {
      data = snap.data();
    });
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          data['username'],
          style: GoogleFonts.workSans(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14.0),
            child: Icon(Icons.menu, color: Colors.black),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .collection('messages')
                .doc(widget.receiver)
                .collection('chats')
                .orderBy("date", descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasData) {
                if (snapshot.data.docs.length < 1) {
                  return Center(
                    child: Text('Say Hi...'),
                  );
                }
              }

              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                physics: AlwaysScrollableScrollPhysics(),
                reverse: true,
                itemBuilder: (context, index) {
                  bool isMe = snapshot.data.docs[index]['senderId'] == user.uid;
                  return SingleMessage(
                      message: snapshot.data.docs[index]['message'],
                      isMe: isMe);
                },
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        // scroll padding
                        // scrollPadding: EdgeInsets.symmetric(
                        //     horizontal:
                        //         MediaQuery.of(context).size.width * 0.2),
                        controller: _textEditingController,
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () async {
                        if (_textEditingController.text.isNotEmpty) {
                          // one to one chat
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.uid)
                              .collection('messages')
                              .doc(widget.receiver)
                              .collection('chats')
                              .add({
                            "senderId": user.uid,
                            "receiverId": widget.receiver,
                            "message": _textEditingController.text,
                            "date": FieldValue.serverTimestamp(),
                          }).then((value) {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(user.uid)
                                .collection('messages')
                                .doc(widget.receiver)
                                .set({
                              "last_message": _textEditingController.text,
                              'time': FieldValue.serverTimestamp(),
                              'read': false,
                            });
                          });

                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(widget.receiver)
                              .collection('messages')
                              .doc(user.uid)
                              .collection('chats')
                              .add({
                            "senderId": user.uid,
                            "receiver": widget.receiver,
                            "message": _textEditingController.text,
                            "date": FieldValue.serverTimestamp()
                          }).then((value) {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.receiver)
                                .collection('messages')
                                .doc(user.uid)
                                .set({
                              "last_message": _textEditingController.text,
                              'time': FieldValue.serverTimestamp(),
                              'read': false,
                            });
                          });
                        }

                        _textEditingController.clear();
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                      backgroundColor: primaryColor,
                      elevation: 0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
