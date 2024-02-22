import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app_tut/components/Comment.dart';
import 'package:social_app_tut/components/CommentButton.dart';
import 'package:social_app_tut/components/LikeButton.dart';
import 'package:social_app_tut/helper/HelperFunc.dart';
import '../components/DeleteButton.dart';

class Post extends StatefulWidget {
  final String title;
  final String subtitle;
  final String postId;
  final List<String> likes;
  const Post({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.postId,
    required this.likes,
  }) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final currentUser = FirebaseAuth.instance.currentUser;
  bool isLiked = false;

  // comment text controller
  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser!.email);
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    // access the document in firestore
    DocumentReference postRef = FirebaseFirestore.instance
        .collection('Posts_Social_App')
        .doc(widget.postId);
    if (isLiked) {
      postRef.update({
        'likes': FieldValue.arrayUnion([currentUser!.email])
      });
    } else {
      postRef.update({
        'likes': FieldValue.arrayRemove([currentUser!.email])
      });
    }
  }

  // add a comment
  void addComment(String commentText) {
    FirebaseFirestore.instance
        .collection('Posts_Social_App')
        .doc(widget.postId)
        .collection('comments')
        .add({
      'text': commentText,
      'commentBy': currentUser!.email,
      'time': DateTime.now()
    });
  }

  // show a comment dialog box
  void showCommentDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Add a comment",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary)),
              content: TextField(
                controller: commentController,
                decoration: InputDecoration(
                    hintText: "Your comment...",
                    hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary)),
              ),
              actions: [
                // save button
                // cancel button
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // clear the text
                    commentController.clear();
                  },
                  child: Text("Cancel",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary)),
                ),
                TextButton(
                  onPressed: () {
                    if (commentController.text.isNotEmpty) {
                      addComment(commentController.text);
                    }
                    Navigator.pop(context);
                    // clear the text
                    commentController.clear();
                  },
                  child: Text("Save",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary)),
                ),
              ],
            ));
  }

  // delete a post
  void deletePost() {
    // ask for confirmation
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Post",
            style:
                TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
        content: Text("Are you sure you want to delete this post?",
            style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary)),
          ),
          TextButton(
            onPressed: () {
              // delete the post
              FirebaseFirestore.instance
                  .collection('Posts_Social_App')
                  .doc(widget.postId)
                  .delete();
              Navigator.pop(context);
            },
            child: Text("Delete",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int commentsCount = 0;

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            // title, subtitle
            ListTile(
              title: Text(widget.title,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary)),
              subtitle: Text(widget.subtitle,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary)),
              trailing: widget.subtitle == currentUser!.email
                  ? DeleteButton(onPressed: deletePost)
                  : null,
            ),

            // Comments
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Posts_Social_App")
                  .doc(widget.postId)
                  .collection("comments")
                  .orderBy("time", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: snapshot.data!.docs.map((doc) {
                    // get the comment
                    final comment = doc.data() as Map<String, dynamic>;
                    // return comment
                    return Comment(
                        text: comment['text'],
                        user: comment['commentBy'],
                        time: formateDate(comment['time']));
                  }).toList(),
                );
              },
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: const Divider(
                color: Colors.grey,
                height: 0,
                thickness: 0.3,
              ),
            ),
            // action icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LikeButton(
                  isLiked: isLiked,
                  onTap: toggleLike,
                  postId: widget.postId,
                  likes: widget.likes,
                ),
                CommentButton(
                  onTap: () => showCommentDialog(),
                  commentCount: commentsCount, // TODO: get the comment count
                )
              ],
            )
          ])),
    );
  }
}
