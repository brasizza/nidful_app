// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/constant/constants.dart';
import 'package:nidful/screens/cat_list.dart';
import 'package:nidful/widgets/bottom_bar.dart';
import 'package:nidful/widgets/category_grid.dart';
import 'package:nidful/widgets/circle_icon.dart';
import 'package:nidful/widgets/input_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var dummyData = [
    {'label': 'Food', 'image': 'assets/product1.png'},
    {'label': 'Gadgets', 'image': 'assets/product2.png'},
    {'label': 'Electronics', 'image': 'assets/product3.png'},
    {'label': 'Household', 'image': 'assets/product4.png'}
  ].toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Appbar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hi Doe 👋',
                                style: GoogleFonts.workSans(
                                    fontSize: 23, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'What are you giving out today?',
                                style: GoogleFonts.workSans(),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              CircleIcon(
                                icon: Icons.add_outlined,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              CircleIcon(
                                icon: Icons.message_outlined,
                              )
                            ],
                          ),
                        ]),
                    // Serchbar
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(child: InputWidget(label: '', hint: 'Search')),
                        SizedBox(width: 7),
                        Column(
                          children: [
                            SizedBox(height: 16),
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: primaryColor,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.filter_list_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: StaggeredGridView.countBuilder(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 16,
                    itemCount: dummyData.length,
                    itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: () {
                        Get.to(() => CatList());
                      },
                      child: CategoryWidget(
                        label: 'Food',
                        image: 'assets/product2.png',
                      ),
                    ),
                    staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                    // mainAxisSpacing: 4.0,
                    // crossAxisSpacing: 4.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
