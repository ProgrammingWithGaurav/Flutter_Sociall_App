import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app_tut/components/MyListTile.dart';
import '../helper/HelperFunc.dart';
import '../components/BackButton.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Users_Social_App')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                displayMessageToUser("Something went wrong!.", context);
              }

              // show loading circle
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              // get all users
              final users = snapshot.data!.docs;
              return Column(
                children: [
                  Padding(
                        padding: const EdgeInsets.only(top: 50, left: 25),
                        child: Row(
                          children: [
                            // BackButton(),
                           MyBackButton(), 
                          ],
                        ),
                      ),

                  const SizedBox(height: 10),
                  // users
                  Expanded(
                    child: ListView.builder(
                        itemCount: users.length,
                        padding: const EdgeInsets.all(0),
                        itemBuilder: (context, index) {
                          // get each user
                          final user = users[index];
                          return MyListTile(title: user['username'], subtitle: user['email']);                    }),
                  ),
                ],
              );
            }));
  }
}
