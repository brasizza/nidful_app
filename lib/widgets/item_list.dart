// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nidful/constant/constants.dart';
import 'package:nidful/models/user.dart' as model;
import 'package:nidful/providers/user_provider.dart';
import 'package:nidful/resources/firestore_methods.dart';
import 'package:nidful/utils/utils.dart';
import 'package:nidful/widgets/color_button.dart';
import 'package:provider/provider.dart';

class ItemList extends StatefulWidget {
  final snap;

  const ItemList({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(widget.snap['postUrl'],
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.snap['title'],
                      style: TextStyle(color: primaryColor, fontSize: 20.sp),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        widget.snap['description'].length > 30
                            ? widget.snap['description'].substring(0, 30) +
                                '...'
                            : widget.snap['description'],
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          widget.snap['category'],
                          style: TextStyle(color: primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Button(
            label: 'Get Item',
            load: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Text(
                    'Get Item',
                    style: TextStyle(color: Colors.white),
                  ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.07,
            function: () async {
              setState(() {
                isLoading = true;
              });
              String res = await FireStoreMethods().getItem(
                postId: widget.snap['postId'],
                uid: widget.snap['uid'],
                requester: FirebaseAuth.instance.currentUser!.uid,
                username: user.username,
                photoUrl: user.photoUrl,
                title: widget.snap['title'],
              );
              if (res != 'success') {
                showSnackBar(res, context);
                // print(res);
              } else {
                showSnackBar('Request has been sent', context);
              }
              setState(() {
                isLoading = false;
              });
            },
          ),
        ],
      ),
    );
  }
}
