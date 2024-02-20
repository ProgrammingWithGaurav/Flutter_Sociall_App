import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_app_tut/auth/LoginOrRegister.dart';
import 'package:social_app_tut/auth/auth.dart';
import 'package:social_app_tut/firebase_options.dart';
import 'package:social_app_tut/pages/Home.dart';
import 'package:social_app_tut/pages/Profile.dart';
import 'package:social_app_tut/pages/Settings.dart';
import 'package:social_app_tut/pages/Users.dart';
import './theme/ThemeProvider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        '/login_register_page': (context) => const LoginOrRegister(),
        '/home_page': (context) =>  HomePage(),
        '/profile_page': (context) => ProfilPage(),
        '/users_page': (context) => const UsersPage(),
        '/settings_page': (context) =>  SettingsPage(),
      },
    );
  }
}
