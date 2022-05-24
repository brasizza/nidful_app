// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/screens/detail_page.dart';
import 'package:nidful/widgets/item_list.dart';

class CatList extends StatelessWidget {
  final String search;
  const CatList({Key? key, required this.search}) : super(key: key);

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
          "Showing Results for 'Food' ",
          style: GoogleFonts.workSans(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('products')
              .where('title', isGreaterThanOrEqualTo: search)
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: (snapshot.data! as dynamic).docs.length,
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.to(() => DetailPage(
                          snap: (snapshot.data! as dynamic).docs[index].data(),
                        ));
                  },
                  child: ItemList(
                    image: (snapshot.data! as dynamic).docs[index]['postUrl'],
                    label: (snapshot.data! as dynamic).docs[index]['title'],
                    desc: (snapshot.data! as dynamic).docs[index]
                        ['description'],
                    cat: (snapshot.data! as dynamic).docs[index]['category'],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
