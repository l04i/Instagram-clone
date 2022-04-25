import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/profile_screen.dart';
import 'package:instagram_clone/screens/search_screen.dart';
import '../screens/add_post_screen.dart';
import '../screens/feeds_screen.dart';

final HomePageItems = [
  const FeedScreen(),
  const SearchScreen(),
  AddPostScreen(),
  const Text('noti'),
   ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,)
];
