// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 350,
          width: 510,
          // color: Colors.red,
          child: FittedBox(
            fit: BoxFit.fill,
            child: Image.asset('assets/slide2.png'),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          padding: EdgeInsets.all(29),
          child: Text(
            'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las',
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 1.0),
            maxLines: 3,
          ),
        ),
      ],
    );
  }
}
