// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/screens/detail_page.dart';
import 'package:nidful/widgets/item_list.dart';

class CatList extends StatelessWidget {
  const CatList({Key? key}) : super(key: key);

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
        child: Column(
          children: [
            ListView(
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => DetailPage(
                          title: 'Macbook Air Pro',
                        ));
                  },
                  child: ItemList(
                    image: 'assets/list1.png',
                    label: 'Giving out Free Food',
                    desc: 'Lorem Ipsum es simplemente .',
                    cat: 'Food',
                  ),
                ),
                ItemList(
                  image: 'assets/list1.png',
                  label: 'Giving out Free Food',
                  desc: 'Lorem Ipsum es simplemente .',
                  cat: 'Food',
                ),
                ItemList(
                  image: 'assets/list1.png',
                  label: 'Giving out Free Food',
                  desc: 'Lorem Ipsum es simplemente .',
                  cat: 'Food',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
