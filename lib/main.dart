

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:provider/provider.dart';

import 'providers/user_provider.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'utilities/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
     ChangeNotifierProvider(create: (_) => UserProvider(),),

    ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor:mobileBackgroundColor 
        ),
        
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active){
            if (snapshot.hasData){
            return const HomeScreen();
            }
              else if (snapshot.hasError){
            return Center(child: Text('${snapshot.error}'),);
              }
            }
            if  (snapshot.connectionState == ConnectionState.active) {
              return const CircularProgressIndicator(color: primaryColor,);
            } else {
              return LoginScreen();
            }
          }
      
        ),
       
      ),
    );
  
}

}