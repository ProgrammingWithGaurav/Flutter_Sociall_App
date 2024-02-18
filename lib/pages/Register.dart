import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app_tut/components/Button.dart';
import 'package:social_app_tut/components/Textfield.dart';
import 'package:social_app_tut/helper/HelperFunc.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  RegisterPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController userNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmController = TextEditingController();

  void register() async {
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    // check if the password and confirm password are the same
    if (passwordController.text != confirmController.text) {
      // pop the dialog
      Navigator.pop(context);

      // show an error message
      displayMessageToUser("Password don't match", context);
    } else {
      // create a user
      try {
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        // create user in the database
        createUserDocument(userCredential);

        // pop the dialog
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        // pop loading circle
        Navigator.pop(context);

        // display error nmessage to the user
        displayMessageToUser(e.code!, context);
      }
    }
  }

  // create  a user
  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection('Users_Social_App')
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'username': userNameController.text,
      });
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

            MyButton(text: "Register", onTap: register),

            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(" Login",
                        style: TextStyle(fontWeight: FontWeight.bold)))
              ],
            )
          ]),
        )));
  }
}
