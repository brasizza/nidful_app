// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryWidget extends StatelessWidget {
  final String label;
  final String image;

  const CategoryWidget({Key? key, required this.label, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          // color: Colors.red,
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(image, scale: 1.0),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          // left: 40,
          child: Center(
            child: Container(
                padding: const EdgeInsets.all(9.0),
                // alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                    width: 90,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black,
                    ),
                    child: Center(
                      child: Text(
                        label,
                        style: GoogleFonts.workSans(
                            color: Colors.white, fontSize: 12),
                      ),
                    ))),
          ),
        ),
      ],
    );
  }
}
