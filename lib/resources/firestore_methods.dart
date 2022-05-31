import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<String> getItem({
    required String postId,
    required String uid,
    required String requester,
    required String username,
    required String photoUrl,
  }) async {
    String res = 'Some error occured';
    String rand = const Uuid().v1();
    try {
      if (FirebaseAuth.instance.currentUser!.uid == uid) {
        res = 'You cant make request on your product';
      } else {
        await _firestore.collection('vets').doc(postId).set({
          'requester': requester,
          'username': username,
          'uid': uid,
          'postId': postId,
          'status': 'pending',
          'date': DateTime.now(),
        });

        await _firestore.collection('Vetnotifications').doc(rand).set({
          'sender': requester,
          'receiver': uid,
          'username': username,
          'postId': postId,
          'date': DateTime.now(),
          'type': 'requesting'
        });
        res = 'success';
      }
    } catch (e) {
      e.toString();
    }

    return res;
  }

  Future<String> itemPingPend({
    required String postId,
    required String uid,
    required String requester,
    required String username,
  }) async {
    String res = 'Some error occured';
    try {
      String Vid = const Uuid().v1();

      // var getData = await _firestore
      //     .collection('vetsPing')
      //     .where('requester', isEqualTo: requester)
      //     .get();
      // if() {

      // }

      await _firestore.collection('vetsPing').doc(Vid).set({
        'requester': requester,
        'username': username,
        'uid': uid,
        'postId': postId,
        'date': DateTime.now(),
        'status': 'pending',
      });

      res = 'success';
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
  }) async {
    String res = 'Some error occured';
    String Vid = const Uuid().v1();
    try {
      await _firestore.collection('vetsPing').doc(Vid).set({
        'requester': requester,
        'username': username,
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
      res = 'success';
    } catch (e) {
      e.toString();
    }

    return res;
  }
}
