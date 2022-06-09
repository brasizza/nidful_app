import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nidful/models/post.dart';
import 'package:nidful/resources/storage_methods.dart';
import 'package:nidful/utils/utils.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // upload products

  Future<String> uploadPost(
    String title,
    String category,
    String condition,
    String qauntity,
    String description,
    String uid,
    String username,
    Uint8List file,
    String profImage,
  ) async {
    String res = 'Some error occured';
    try {
      String photoUrl = await StorageMethods()
          .uploadImageToStorage('products', file, true, false);

      String postId = const Uuid().v1();

      Post post = Post(
        title: title,
        category: category,
        condition: condition,
        quantity: qauntity,
        description: description,
        uid: uid,
        username: username,
        postId: postId,
        datePosted: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
        likes: [],
      );

      _firestore.collection('products').doc(postId).set(
            post.toJson(),
          );
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likeProduct(String postId, String uid, String ownerId,
      List likes, String username, String photoUrl, String postUrl) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('products').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
        bool isNotPostOwner = uid != ownerId;
        if (isNotPostOwner) {
          removeNotificationLike(ownerId, postId);
        }
      } else {
        await _firestore.collection('products').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
        bool isNotPostOwner = uid != ownerId;
        if (isNotPostOwner) {
          addNotificationLike(
              uid, ownerId, username, postId, photoUrl, postUrl);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  addNotificationLike(
    String uid,
    String ownerId,
    String username,
    String postId,
    String photoUrl,
    String postUrl,
  ) {
    FirebaseFirestore.instance
        .collection('notifications')
        .doc(ownerId)
        .collection('userNotifications')
        .doc(postId)
        .set({
      'type': 'like',
      'postId': postId,
      'timestamp': DateTime.now().toString(),
      'read': false,
      'username': username,
      'userImg': photoUrl,
      'postUrl': postUrl,
    });
  }

  removeNotificationLike(
    String ownerId,
    String postId,
  ) {
    FirebaseFirestore.instance
        .collection('notifications')
        .doc(ownerId)
        .collection('userNotifications')
        .doc(postId)
        .get()
        .then((value) {
      if (value.exists) {
        value.reference.delete();
      }
    });
  }

  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];
      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> updateuser(
    String firstname,
    String lastname,
    String username,
    String email,
    String bio,
    Uint8List? file,
  ) async {
    String res = 'Some error occured';

    if (file != null) {
      String photoUrl = await StorageMethods()
          .uploadImageToStorage('users', file, true, false);
      try {
        await _firestore
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          'firstname': firstname,
          'lastname': lastname,
          'username': username,
          'email': email,
          'bio': bio,
          'photoUrl': photoUrl,
        });
        res = 'success';
      } catch (e) {
        print(e.toString());
      }
    } else {
      try {
        await _firestore
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          'firstname': firstname,
          'lastname': lastname,
          'username': username,
          'email': email,
          'bio': bio,
        });
        res = 'success';
      } catch (e) {
        print(e.toString());
      }
    }

    return res;
  }

  Future<String> getItem({
    required String postId,
    required String uid,
    required String requester,
    required String username,
    required String photoUrl,
    required String title,
  }) async {
    String res = 'Some error occured';
    String rand = const Uuid().v1();
    try {
      var data = await _firestore
          .collection('vets')
          .where('postId', isEqualTo: postId)
          .where('requester', isEqualTo: requester)
          .get();
      if (data.docs.isEmpty) {
        if (FirebaseAuth.instance.currentUser!.uid == uid) {
          res = 'You cant make request on your product';
        } else {
          await _firestore.collection('vets').doc(postId).set({
            'requester': requester,
            'username': username,
            'uid': uid,
            'postId': postId,
            'photoUrl': photoUrl,
            'status': 'pending',
            'date': DateTime.now(),
          });

          await _firestore
              .collection('notifications')
              .doc(uid)
              .collection('userNotifications')
              .add({
            'sender': requester,
            'receiver': uid,
            'username': username,
            'postId': postId,
            'title': title,
            'timestamp': DateTime.now().toString(),
            'type': 'requesting',
            'read': 'false',
          });
          res = 'success';
        }
      } else {
        res = 'You have already made a request on this product';
      }
    } catch (e) {
      e.toString();
    }

    return res;
  }

  Future<String> itemPingAccept({
    required String postId,
    required String uid,
    required String requester,
    required String username,
    required String giver,
  }) async {
    String res = 'Some error occured';
    try {
      String Vid = const Uuid().v1();

      var getData = await _firestore
          .collection('vetsPing')
          .where('requester', isEqualTo: requester)
          .get();
      if (getData.docs.isNotEmpty) {
        Get.snackbar(
          'Info',
          'Request sent has been sent to ${username} before',
          backgroundColor: Colors.yellow[700],
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          borderRadius: 10,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
        );
      } else {
        await _firestore.collection('vets').doc(postId).update({
          'status': 'accepted',
        });

        await _firestore.collection('vetsPing').doc(Vid).set({
          'postId': postId,
          'uid': uid,
          'requester': requester,
          'username': username,
          'giver': giver,
          'date': DateTime.now(),
          'status': 'accepted',
        });

        await _firestore
            .collection('notifications')
            .doc(requester)
            .collection('userNotifications')
            .add({
          'sender': uid,
          'receiver': requester,
          'username': username,
          'giver': giver,
          'postId': postId,
          'timestamp': DateTime.now().toString(),
          'type': 'accepted',
          'read': 'false',
        });

        res = 'success';
      }
    } catch (e) {
      e.toString();
    }

    return res;
  }

  Future<String> itemPingReject({
    required String postId,
    required String uid,
    required String requester,
    required String username,
    required String giver,
  }) async {
    String res = 'Some error occured';
    String Vid = const Uuid().v1();
    try {
      await _firestore.collection('vetsPing').doc(Vid).set({
        'requester': requester,
        'username': username,
        'giver': giver,
        'uid': uid,
        'postId': postId,
        'date': DateTime.now(),
        'status': 'rejected',
      });
      res = 'success';
    } catch (e) {
      e.toString();
    }

    return res;
  }

  Future<String> acceptVet({
    required String postId,
  }) async {
    String res = 'Some error occured';
    try {
      await _firestore.collection('vets').doc(postId).update({
        'status': 'accepted',
      });

      // await _firestore.collection('Vetnotifications').doc(postId).update({
      //   'type': 'accepted',
      // });
      res = 'success';
    } catch (e) {
      e.toString();
    }

    return res;
  }

  // Future<String> acceptedVet({
  //   required String postId,
  //   required String username,
  //   required String requester,
  // }) async {
  //   String res = 'Some error occured';
  //   try {
  //     await _firestore
  //         .collection('Vetnotifications')
  //         .doc(postId)
  //         .collection('getNotify')
  //         .doc(requester)
  //         .set({
  //       'type': 'accepted',
  //       'username': username,
  //       'requester': requester,
  //       'postId': postId,
  //     });
  //     res = 'success';
  //   } catch (e) {
  //     e.toString();
  //   }

  //   return res;
  // }
}
