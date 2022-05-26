// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nidful/constant/constants.dart';

class CircleIcon extends StatelessWidget {
  final icon;
  final bool isSvg;
  final double? iconSize;
  const CircleIcon({Key? key, this.icon, this.iconSize, this.isSvg = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(13.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: primaryColor,
      ),
      child: isSvg
          ? SvgPicture.asset(
              icon,
              width: 20,
              height: 20,
            )
          : Icon(
              icon,
              color: Colors.white,
              size: iconSize ?? 14,
            ),
    );
  }
}
