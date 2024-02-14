import 'package:flutter/material.dart';
import 'package:social_app_tut/auth/LoginOrRegister.dart';
import './theme/DarkMode.dart';
import './theme/LightMode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginOrRegister(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
