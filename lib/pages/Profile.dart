import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  // current logged in user
  final User? user = FirebaseAuth.instance.currentUser;

  ProfilPage({super.key});

  // fetch user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection('Users_Social_App')
        .doc(user!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: getUserDetails(),
            builder: (context, snapshot) {
              // loading
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              // error
              else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }

              // data received
              else if (snapshot.hasData) {
                Map<String, dynamic>? user = snapshot.data!.data();

                return Center(
                    child: Column(
                        children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50, left: 25),
                        child: Row(
                          children: [
                            // BackButton(),
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(10),
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child:  Icon(
                                  Icons.arrow_back,
                                  color: Theme.of(context).colorScheme.inversePrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),
                      // Profile Pic
                      Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.all(25.0),
                          child: Icon(Icons.person, size: 64, color: Theme.of(context).colorScheme.inversePrimary)),
                      const SizedBox(height: 25),

                      // Username and Email
                      Text(user!["username"],
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),

                      const SizedBox(height: 10),
                      Text(
                        user["email"],
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ]));
              } else {
                return const Text("No Data");
              }
            }));
  }
}
