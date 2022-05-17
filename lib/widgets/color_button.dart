import 'package:flutter/material.dart';
import 'package:nidful/constant/constants.dart';

class Button extends StatelessWidget {
  final String label;
  final double? width;
  final double? height;
  final Color? color;
  final Color? textcolor;
  const Button(
      {Key? key,
      required this.label,
      this.width,
      this.height,
      this.color,
      this.textcolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(color: textcolor ?? Colors.white),
        ),
      ),
    );
  }
}
