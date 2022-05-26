import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nidful/models/post.dart';
import 'package:nidful/resources/storage_methods.dart';
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

  Future<void> likeProduct(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('products').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('products').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
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
    Uint8List file,
  ) async {
    String res = 'Some error occured';

    String photoUrl = await StorageMethods()
        .uploadImageToStorage('profile', file, false, true);

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

    return res;
  }
}
