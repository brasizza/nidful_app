// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:nidful/constant/constants.dart';
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
            child: PageView(
              controller: _controller,
              children: [
                Page1(),
                Page2(),
                Page3(),
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: _controller,
            count: 3,
            effect: CustomizableEffect(
              activeDotDecoration: DotDecoration(
                width: 15,
                height: 15,
                color: Colors.indigo,
                rotationAngle: 180,
                verticalOffset: -0,
                borderRadius: BorderRadius.all(Radius.circular(50)),
                dotBorder: DotBorder(
                  padding: 2,
                  width: 2,
                  color: Colors.indigo,
                ),
              ),
              dotDecoration: DotDecoration(
                width: 15,
                height: 15,
                color: Colors.grey,
                // dotBorder: DotBorder(
                //   padding: 2,
                //   width: 2,
                //   color: Colors.grey,
                // ),
                // borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(2),
                //     topRight: Radius.circular(16),
                //     bottomLeft: Radius.circular(16),
                //     bottomRight: Radius.circular(2)),
                borderRadius: BorderRadius.all(Radius.circular(50)),
                verticalOffset: 0,
              ),
              spacing: 6.0,
              // activeColorOverride: (i) => colors[i],
              // inActiveColorOverride: (i) => colors[i],
            ),
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    ));
  }
}
