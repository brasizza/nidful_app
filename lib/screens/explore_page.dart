// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/widgets/posts.dart';

class ExplorePage extends StatefulWidget {
  final _controller = PageController(initialPage: 0);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Explore',
          style: GoogleFonts.workSans(color: Colors.black),
        ),
      ),
      body: Entry.opacity(
        duration: Duration(seconds: 1),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return PageView.builder(
              controller: widget._controller,
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Posts(
                  snap: snapshot.data!.docs[index].data(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
