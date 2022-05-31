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

  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Precious", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey John, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "How do you wanna get your product John",
        messageType: "sender"),
  ];

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
                .collection('messages')
                .doc(user.uid)
                .collection('chats')
                .doc(widget.receiver)
                .collection('messages')
                .snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment: ((snapshot.data!.docs[index]['messageType'] !=
                              "sender")
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ((snapshot.data!.docs[index]['messageType'] !=
                                  "sender")
                              ? Colors.grey.shade200
                              : primaryColor),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          (snapshot.data!.docs[index]['message']),
                          style: TextStyle(
                              fontSize: 15,
                              color: (snapshot.data!.docs[index]
                                          ['messageType'] !=
                                      "sender")
                                  ? Colors.black
                                  : Colors.white),
                        ),
                      ),
                    ),
                  );
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
                      onPressed: () {
                        if (_textEditingController.text.isNotEmpty) {
                          FirebaseFirestore.instance
                              .collection('messages')
                              .doc(user.uid)
                              .collection('chats')
                              .doc(widget.receiver)
                              .collection('messages')
                              .add({
                            'message': _textEditingController.text,
                            'receiver': widget.receiver,
                            'sender': FirebaseAuth.instance.currentUser!.uid,
                            'timestamp': DateTime.now(),
                            'messageType': 'sender',
                            'username': user.username,
                          });
                        }
                        // setState(() {
                        //   messages.add(
                        //     ChatMessage(
                        //         messageContent: _textEditingController.text,
                        //         messageType: "sender"),
                        //   );
                        // });
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
