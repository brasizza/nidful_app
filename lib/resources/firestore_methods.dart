import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
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
      String photoUrl =
          await StorageMethods().uploadImageToStorage('products', file, true);

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
}
