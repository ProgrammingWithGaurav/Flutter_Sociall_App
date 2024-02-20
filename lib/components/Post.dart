import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app_tut/components/LikeButton.dart';

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          title: Text(widget.title,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary)),
          subtitle: Text(widget.subtitle,
              style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
          trailing: LikeButton(
            isLiked: isLiked,
            onTap: toggleLike,
            postId: widget.postId,
            likes: widget.likes,
          ),
        ),
      ),
    );
  }
}
