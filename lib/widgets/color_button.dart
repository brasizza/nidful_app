import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/constant/constants.dart';

class Button extends StatelessWidget {
  final String label;
  final load;
  final double? width;
  final double? height;
  final Color? color;
  final Color? textcolor;
  final double? fontsize;

  final Function()? function;
  const Button(
      {Key? key,
      required this.label,
      this.width,
      this.height,
      this.color,
      this.textcolor,
      this.function,
      this.fontsize,
      this.load})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: load ??
              Text(
                label,
                style: GoogleFonts.workSans(
                    color: textcolor ?? Colors.white, fontSize: fontsize ?? 20),
              ),
        ),
      ),
    );
  }
}
