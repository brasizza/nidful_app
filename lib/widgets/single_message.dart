// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:nidful/constant/constants.dart';

class SingleMessage extends StatelessWidget {
  final String message;
  final bool isMe;
  const SingleMessage({Key? key, required this.message, required this.isMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(16),
          constraints: BoxConstraints(maxHeight: 200),
          decoration: BoxDecoration(
            color: isMe ? primaryColor : Colors.grey[300],
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
