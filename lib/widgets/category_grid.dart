// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final String label;
  final String image;

  const CategoryWidget({Key? key, required this.label, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 40,
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
                        style: TextStyle(color: Colors.white),
                      ),
                    ))),
          ),
        ),
      ],
    );
  }
}
