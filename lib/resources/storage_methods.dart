import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
final FirebaseStorage _storage = FirebaseStorage.instance; 
final FirebaseAuth _auth = FirebaseAuth.instance;


Future<String> uploadImageToStorage(String childName , File file , bool isPost ) async {
Reference ref = FirebaseStorage.instance.ref().child(childName).child(_auth.currentUser!.uid);

if(isPost){
  String id = const Uuid().v1();
  ref = ref.child(id);
}

UploadTask uploadTask = ref.putFile(file);
TaskSnapshot taskSnapshot = await uploadTask;
return await ref.getDownloadURL();
}
 


}