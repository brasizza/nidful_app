import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FollowersController extends GetxController {
  // Get list of followers from firebase users collection
  // final followers = [].obs;
  // final following = [].obs;

  Rx<List<dynamic>> followers = Rx<List<dynamic>>([]);
  Rx<List<dynamic>> following = Rx<List<dynamic>>([]);

  Future<List> getFollowers(uid) async {
    try {
      DocumentSnapshot snap =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      List followersData = (snap.data()! as dynamic)['followers'];
      // Get the list of followers
      if (followersData != null) {
        followersData.forEach((f) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(f)
              .get()
              .then((doc) {
            if (doc.exists) {
              // print(followers.length);
              // followers = [...followers, doc.data()];
              followers.value.add(doc.data());
              // pass followers
              // return followers;
            }
          });
        });
        // clear the list
        followers.value = [];
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List> getFollowing(uid) async {
    try {
      DocumentSnapshot snap =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      List followingData = (snap.data()! as dynamic)['following'];
      // print(followingData);
      // Get the list of followers
      if (following != null) {
        followingData.forEach((f) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(f)
              .get()
              .then((doc) {
            if (doc.exists) {
              // print(followingData.length);
              following.value.add(doc.data());
              // pass followers
              // return followers;
            }
          });
        });
        following.value = following.value;
      }
      // return following;
    } catch (e) {
      print(e);
    }
    return [];
  }
}
