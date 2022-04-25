import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

import 'storage_methods.dart';
import '../models/post.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadPost(String description, File file, String uid,
      String username, String profImg) async {
    String res = "";

    try {
      if (description.isNotEmpty ||
          uid.isNotEmpty ||
          username.isNotEmpty ||
          profImg.isNotEmpty ||
          file != null) {
        String photoURL =
            await StorageMethods().uploadImageToStorage("posts", file, true);

        String postId = const Uuid().v1();

        Post _post = Post(
            description: description,
            uid: _auth.currentUser!.uid,
            photoURL: photoURL,
            username: username,
            postId: postId,
            datePublished: DateTime.now(),
            profImg: profImg,
            likes: []);

        await _firestore.collection("posts").doc(postId).set(_post.toJson());
        res = "success";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid))
        await _firestore.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayRemove([uid]),
        });
      else
        await _firestore.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayUnion([uid]),
        });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> postComment(String postId, String text, String name,
      String profilePic, String uid) async {
    try {
      if (text.isNotEmpty) {
        String commentId = Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          "profilePic": profilePic,
          "name": name,
          "uid": uid,
          'text': text,
          'commentId': commentId,
          "datePublished": DateTime.now(),
        });
      } else {
        print("text is empty");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> followUsers(String uid, String followId) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection("users").doc(followId).get();
      final following = (snapshot.data() as dynamic)['following'];
      if (following.contains(uid)) {
        await _firestore.collection("users").doc(uid).update({
          "following": FieldValue.arrayRemove([followId])
        });

        await _firestore.collection("users").doc(followId).update({
          "followers": FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection("users").doc(uid).update({
          "following": FieldValue.arrayUnion([followId])
        });

        await _firestore.collection("users").doc(followId).update({
          "followers": FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
