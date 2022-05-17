// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:nidful/pageV/page1.dart';
import 'package:nidful/pageV/page2.dart';
import 'package:nidful/pageV/page3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoradScreen extends StatelessWidget {
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.maxFinite,
      child: Column(
        children: [
          Flexible(
            flex: 1,
            // height: double.maxFinite,
            child: PageView(
              controller: _controller,
              children: [
                Page1(),
                Page2(),
                Page3(),
              ],
            ),
          ),
          SmoothPageIndicator(controller: _controller, count: 3),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    ));
  }
}
