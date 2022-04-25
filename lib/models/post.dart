import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Post {
  final String description;
  final String uid;
  final String photoURL;
  final String username;
  final String postId;
  final DateTime datePublished;
  final String profImg;
  final likes;
  
  Post({
    required this.description,
    required this.uid,
    required this.photoURL,
    required this.username,
    required this.postId,
    required this.datePublished,
    required this.profImg,
    required this.likes,
  });


  
  
  
Map<String , dynamic> toJson(){
  
  return { 
     'description': description,
      'uid': uid, 
      'photoURL': photoURL, 
      'username': username, 
      'postId': postId,
      'datePublished': datePublished,
      'profImg': profImg,
      'likes' : likes,
};

  
}
}