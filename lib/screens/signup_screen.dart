import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import '../resources/auth_methods.dart';
import 'login_screen.dart';
import '../utilities/colors.dart';
import '../utilities/utils.dart';
import '../widgets/text_field_input.dart';
import 'dart:io';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  File? _img;
  bool _isLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  void selectImage() async {
    _img = await pickImage(ImageSource.gallery);
    setState(() {
      _img;
    });
  }

  void signupUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().singupUser(
        emailController.text,
        passwordController.text,
        usernameController.text,
        bioController.text,
        _img!);

    setState(() {
      _isLoading = false;
    });

    if (res != 'success')
      showSnackBar(res, context);
    else
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    bioController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Center(
            child: ListView(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Container(),
                      flex: 2,
                    ),
                  ],
                ),
                SvgPicture.asset(
                  'assets/ic_instagram.svg',
                  color: primaryColor,
                  height: 64,
                ),
                const SizedBox(height: 64),
                Center(
                  child: Stack(
                    children: [
                      _img == null
                          ? const CircleAvatar(
                              radius: 64,
                              backgroundImage: NetworkImage(
                                  'https://www.maxpixel.net/static/photo/1x/Insta-Instagram-Instagram-Icon-User-3814081.png'),
                            )
                          : CircleAvatar(
                              radius: 64,
                              backgroundImage: FileImage(_img!),
                            ),
                      Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(Icons.add_a_photo),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                TextFieldInput(
                  hintText: "Enter your username",
                  textInputType: TextInputType.text,
                  textEditingController: usernameController,
                  isPass: false,
                ),
                const SizedBox(height: 24),
                TextFieldInput(
                  hintText: "Enter your email",
                  textInputType: TextInputType.emailAddress,
                  textEditingController: emailController,
                  isPass: false,
                ),
                const SizedBox(height: 24),
                TextFieldInput(
                  hintText: "Enter your password",
                  textInputType: TextInputType.text,
                  textEditingController: passwordController,
                  isPass: true,
                ),
                const SizedBox(height: 24),
                TextFieldInput(
                  hintText: "Enter your bio",
                  textInputType: TextInputType.text,
                  textEditingController: bioController,
                  isPass: false,
                ),
                const SizedBox(height: 24),
                InkWell(
                  onTap: signupUser,
                  child: Container(
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: primaryColor,
                          )
                        : const Text("Signup"),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      color: blueColor,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Flexible(
                      child: Container(),
                      flex: 2,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text("Have an account? "),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Container(
                        child: const Text(
                          "Log in ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
