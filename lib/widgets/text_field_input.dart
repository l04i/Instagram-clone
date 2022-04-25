import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
 

 TextFieldInput({Key? key ,required this.hintText,required this.isPass , required this.textEditingController , required this.textInputType});

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText:hintText ,
       border: inputBorder,
       focusedBorder: inputBorder,
       filled: true,
       contentPadding: const EdgeInsets.all(8),
      ),
      obscureText: isPass ,
      keyboardType: textInputType,
    );
  }
}