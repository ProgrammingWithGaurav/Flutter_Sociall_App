import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app_tut/components/Button.dart';
import 'package:social_app_tut/components/Textfield.dart';
import 'package:social_app_tut/helper/HelperFunc.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  void login() async {
    // show the loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // log the user in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // pop the loading circle
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);

      // display error message to the user
      displayMessageToUser(e!.code, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // Logo
            Icon(Icons.person,
                size: 80, color: Theme.of(context).colorScheme.inversePrimary),

            const SizedBox(height: 25),

            const Text("Social App", style: TextStyle(fontSize: 20)),

            const SizedBox(height: 50),

            MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: emailController),

            const SizedBox(height: 10),

            MyTextField(
                hintText: "Password",
                obscureText: true,
                controller: passwordController),

            const SizedBox(height: 10),

            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text("Forgot Password?",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary)),
            ]),
            const SizedBox(height: 25),

            MyButton(text: "Login", onTap: login),

            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(" Register",
                        style: TextStyle(fontWeight: FontWeight.bold)))
              ],
            )
          ]),
        )));
  }
}
