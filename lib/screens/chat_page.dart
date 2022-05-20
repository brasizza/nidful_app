// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/constant/constants.dart';
import 'package:nidful/models/chatMessageModel.dart';
// import 'package:nidful/widgets/bottom_bar.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();

  final TextEditingController _textEditingController = TextEditingController();
}

class _ChatPageState extends State<ChatPage> {
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
          "John Doe",
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
          ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding:
                    EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                child: Align(
                  alignment: (messages[index].messageType == "receiver"
                      ? Alignment.topLeft
                      : Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (messages[index].messageType == "receiver"
                          ? Colors.grey.shade200
                          : primaryColor),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(
                      messages[index].messageContent,
                      style: TextStyle(
                          fontSize: 15,
                          color: messages[index].messageType == "receiver"
                              ? Colors.black
                              : Colors.white),
                    ),
                  ),
                ),
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
                        controller: widget._textEditingController,
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
                        setState(() {
                          messages.add(
                            ChatMessage(
                                messageContent:
                                    widget._textEditingController.text,
                                messageType: "sender"),
                          );
                        });
                        widget._textEditingController.clear();
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
