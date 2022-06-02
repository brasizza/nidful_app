import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String firstname;
  final String lastname;
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final String token;
  final List followers;
  final List following;

  const User({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.bio,
    required this.token,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        'firstname': firstname,
        'lastname': lastname,
        'username': username,
        'uid': uid,
        'email': email,
        'photoUrl': photoUrl,
        'bio': bio,
        'token': token,
        'followers': followers,
        'following': following,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      firstname: snapshot['firstname'] ?? 'Dummy Data',
      lastname: snapshot['lastname'] ?? 'Dummy Data',
      username: snapshot['username'] ?? 'Dummy Data',
      uid: snapshot['uid'] ?? 'Dummy Data',
      email: snapshot['email'] ?? 'Dummy Data',
      photoUrl: snapshot['photoUrl'] ?? 'No image',
      bio: snapshot['bio'] ?? 'Dummy Data',
      token: snapshot['token'] ?? 'Dummy Data',
      followers: snapshot['followers'] ?? [],
      following: snapshot['following'] ?? [],
    );
  }
}
