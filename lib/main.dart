import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_app_tut/auth/auth.dart';
import 'package:social_app_tut/firebase_options.dart';
import './theme/DarkMode.dart';
import './theme/LightMode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
