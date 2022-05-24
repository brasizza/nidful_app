import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String title;
  final String category;
  final String condition;
  final String quantity;
  final String description;
  final String username;
  final String uid;
  final String postId;
  final datePosted;
  final String postUrl;
  final String profImage;
  final likes;

  const Post({
    required this.title,
    required this.category,
    required this.condition,
    required this.quantity,
    required this.description,
    required this.username,
    required this.uid,
    required this.postId,
    required this.datePosted,
    required this.postUrl,
    required this.profImage,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'category': category,
        'condition': condition,
        'quantity': quantity,
        'description': description,
        'username': username,
        'uid': uid,
        'postId': postId,
        'datePosted': datePosted,
        'postUrl': postUrl,
        'profImage': profImage,
        'likes': likes,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      title: snapshot['title'],
      category: snapshot['category'],
      condition: snapshot['condition'],
      quantity: snapshot['quantity'],
      description: snapshot['description'],
      username: snapshot['username'],
      uid: snapshot['uid'],
      postId: snapshot['postId'],
      datePosted: snapshot['datePosted'],
      postUrl: snapshot['postUrl'],
      profImage: snapshot['profImage'],
      likes: snapshot['likes'],
    );
  }
}
