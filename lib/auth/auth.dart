import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app_tut/auth/LoginOrRegister.dart';
import 'package:social_app_tut/pages/Home.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // if user is logged in
        if (snapshot.hasData)
          return  HomePage();
        // if user is not logged in
        else
          return const LoginOrRegister();
      },
    ));
  }
}
