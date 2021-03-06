import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String profileName;
  final String username;
  final String url;
  final String email;
  final String bio;

  User({
    this.id,
    this.profileName,
    this.username,
    this.url,
    this.email,
    this.bio,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    Map getDocs = doc.data();
    return User(
      id: doc.id,
      email: getDocs["email"],
      username: getDocs["username"],
      url: getDocs["url"],
      profileName: getDocs["profileName"],
      bio: getDocs["bio"],
    );
  }
}