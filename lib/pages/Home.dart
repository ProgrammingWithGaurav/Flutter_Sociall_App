import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app_tut/components/Drawer.dart';
import 'package:social_app_tut/components/MyListTile.dart';
import 'package:social_app_tut/components/Post.dart';
import 'package:social_app_tut/components/PostButton.dart';
import 'package:social_app_tut/components/Textfield.dart';
import 'package:social_app_tut/db/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // text controller
  final TextEditingController controller = TextEditingController();
  final FirestoreDatabase database = FirestoreDatabase();

  void postMessage() {
    if (controller.text.isNotEmpty) {
      // post message
      database.postMessage(controller.text);
    }
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: const Text("Posts"),
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          elevation: 0,
          centerTitle: true,
        ),
        drawer: const MyDrawer(),
        body: Column(children: [
          // textfield

          Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                children: [
                  Expanded(
                    child: MyTextField(
                      hintText: "What's on your mind?",
                      obscureText: false,
                      controller: controller,
                    ),
                  ),
                  // post button
                  PostButton(
                    onTap: postMessage,
                  )
                ],
              )),

          // Posts
          StreamBuilder(
              stream: database.readPosts(),
              builder: (context, snapshot) {
                // show loading circle
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                // get all posts
                final posts = snapshot.data!.docs;
                // no data?
                if (snapshot.data == null || posts.isEmpty) {
                  return const Center(
                      child: Padding(
                          padding: EdgeInsets.all(25),
                          child: Text("No posts yet")));
                }

                // show posts
                return Expanded(
                    child: ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];

                          // return as a lite tile
                          return Post(
                            title: post['message'],
                            subtitle: post['email'],
                            likes: List<String>.from(post['likes'] ?? []),
                            postId: post.id,
                          );
                        }));
              })
        ]));
  }
}
