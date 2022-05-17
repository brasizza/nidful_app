// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:nidful/widgets/posts.dart';

class ExplorePage extends StatefulWidget {
  final _controller = PageController(initialPage: 0);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final List<dynamic> data = [
    {
      'image': 'assets/product1.png',
      'userProfileImage': 'assets/user.png',
      'name': 'Precious Oladele',
      'label': 'Giving out Ipad 2020',
      'likeCount': '15',
    },
    {
      'image': 'assets/product2.png',
      'userProfileImage': 'assets/user2.png',
      'name': 'John Doe',
      'label': 'Giving out',
      'likeCount': '15',
    },
    {
      'image': 'assets/product3.png',
      'userProfileImage': 'assets/user.png',
      'name': 'Precious Oladele',
      'label': 'Food',
      'likeCount': '999',
    },
    {
      'image': 'assets/product4.png',
      'userProfileImage': 'assets/user2.png',
      'name': 'Precious Oladele',
      'label': 'Giving out stuffs',
      'likeCount': '50',
    },
    {
      'image': 'assets/tik.png',
      'userProfileImage': 'assets/user.png',
      'name': 'Precious Oladele',
      'label': 'Give away',
      'likeCount': '1050',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: widget._controller,
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Posts(
            image: data[index]['image'],
            userProfileImage: data[index]['userProfileImage'],
            name: data[index]['name'],
            label: data[index]['label'],
            likeCount: data[index]['likeCount'],
          );
        },
      ),
    );
  }
}
