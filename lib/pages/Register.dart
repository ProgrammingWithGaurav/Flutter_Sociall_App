import 'package:flutter/material.dart';
import 'package:social_app_tut/components/Button.dart';
import 'package:social_app_tut/components/Textfield.dart';

class RegisterPage extends StatelessWidget {
  final void Function()? onTap;

  RegisterPage({Key? key, required this.onTap}) : super(key: key);

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  void login() {}

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
                hintText: "Username",
                obscureText: false,
                controller: userNameController),

            const SizedBox(height: 10),
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
            MyTextField(
                hintText: "Confirm Password",
                obscureText: true,
                controller: confirmController),

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
                Text("Already have an account?"),
                GestureDetector(
                    onTap: onTap,
                    child: const Text(" Login",
                        style: TextStyle(fontWeight: FontWeight.bold)))
              ],
            )
          ]),
        )));
  }
}
