

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  final String email;
  final String uid;
  final String photoURL;
  final String username;
  final String bio;
  final List followers;
  final List following;
  
  User({
    required this.email,
    required this.uid,
    required this.photoURL,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following,
  });

  
Map<String , dynamic> toJson(){
  
  return {
 "email" :email,
  "uid": uid,
  "photoURL": photoURL,
  "username" : username,
  "bio" : bio,
  "followers": followers,
  "following" : following,
  };
}

static Future<User> fromSnap(DocumentSnapshot snapshot ) async {
  var snap = (snapshot.data() as Map<String , dynamic>);
  return User(
    email: snap['email'],
    username:snap['username'],
    uid: snap['uid'],
    bio:snap['bio'],
    photoURL:snap['photoURL'],
    followers:snap['followers'],
    following: snap['following'],
  
  );
}



}
