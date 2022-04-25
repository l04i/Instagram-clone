import 'package:flutter/cupertino.dart';
import '../models/user.dart';
import '../resources/auth_methods.dart';

class UserProvider extends ChangeNotifier{
  User? _user;

 User getUser(){
   if (_user != null) {
   return _user!;
   }
   else {
   return User(email: "default", uid: "default", photoURL: "default", username: "default", bio: "default", followers: [], following: []);
   }
 }


Future<void> refreshUser() async {
  User user = await AuthMethods().getUserDetails();
  _user = user;
  notifyListeners();
}

}