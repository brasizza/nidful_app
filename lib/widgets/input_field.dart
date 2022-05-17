// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nidful/constant/constants.dart';

class InputWidget extends StatefulWidget {
  final String label;
  final String? hint;
  final double? height;
  final bool isObscure;

  const InputWidget(
      {Key? key,
      required this.label,
      this.hint,
      this.isObscure = false,
      this.height})
      : super(key: key);

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        widget.label,
        style: GoogleFonts.workSans(
            color: Colors.black, fontWeight: FontWeight.w500),
      ),
      SizedBox(height: 3),
      Container(
          height: widget.height ?? 60,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          decoration: BoxDecoration(
            border: Border.all(color: primaryColor, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hint,
              hintStyle: GoogleFonts.workSans(),
            ),
            obscureText: widget.isObscure,
          )),
    ]);
  }
}
