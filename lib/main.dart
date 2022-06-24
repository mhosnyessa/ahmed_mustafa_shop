import 'package:ahmed_mustafa_amazon/authentication/view/login_screen.dart';
import 'package:ahmed_mustafa_amazon/authentication/view/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: LoginPage(),
      home: SignupPage(),
    );
  }
}
