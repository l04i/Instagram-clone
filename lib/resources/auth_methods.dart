import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'storage_methods.dart';
import '../models/user.dart' as model;

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
 final FirebaseFirestore _firestore = FirebaseFirestore.instance; 



Future<model.User> getUserDetails () async {
  DocumentSnapshot snapshot = await _firestore.collection('users').doc(_auth.currentUser!.uid).get();
  return model.User.fromSnap(snapshot);

}




 Future<String> singupUser(
 String email,
 String password,
 String username,
 String bio,
File file,
 ) async
 {
String res = "some error ocured"; 
try{
if (email.isNotEmpty || password.isNotEmpty ||username.isNotEmpty ||bio.isNotEmpty ||file != null){
UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
    email: email,
    password: password,

    );
    

    String photoURL = await StorageMethods().uploadImageToStorage("profilePics", file, false);

    model.User user = model.User(
     username: username,
     uid: userCredential.user!.uid,
     email: email,
     bio: bio,
     followers: [],
     following: [],
     photoURL: photoURL,
);
    
    await _firestore.collection('users').doc(userCredential.user!.uid).set(user.toJson());

 res = "success";

} 
}

on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    res = 'The password provided is too weak';
  } else if (e.code == 'email-already-in-use') {
    res = 'The account already exists for that email.';
  }
}






catch(e){
  res = e.toString();
}

return res;
}

Future<String> loginuser(String email , String password) async{
  String res = "";
try {
  if (email.isNotEmpty || password.isNotEmpty){
  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
  res = 'success';
}
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    res = 'No user found for that email.';
  } else if (e.code == 'wrong-password') {
    res = 'Wrong password provided for that user.';
  }
}
catch(e){
  res = e.toString();
}

return res;

}

Future<void> signOut()async{
  await _auth.signOut();

}


}
