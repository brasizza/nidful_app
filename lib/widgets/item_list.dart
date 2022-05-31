// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
            width: double.maxFinite,
            height: 200,
            child: Row(
              children: [
                Container(
                  width: 110,
                  height: 110,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(widget.snap['postUrl']),
                  ),
                ),
                SizedBox(width: 18),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.snap['title'],
                      style: TextStyle(color: primaryColor),
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
                          fontSize: 12,
                          color: Colors.grey,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
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
            width: 400,
            height: 57,
            function: () async {
              setState(() {
                isLoading = true;
              });
              String res = await FireStoreMethods().getItem(
                postId: widget.snap['postId'],
                uid: widget.snap['uid'],
                requester: FirebaseAuth.instance.currentUser!.uid,
                username: user.username,
              );
              if (res != 'success') {
                showSnackBar(res, context);
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
