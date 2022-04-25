import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

    final ImagePicker _picker = ImagePicker();

pickImage (ImageSource source) async {
    
    final XFile? image = await _picker.pickImage(source: source);
 
    if (image != null)
    
    return File(image.path);
    
}

showSnackBar (String content , BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text(content)),
  );
}
