import 'package:flutter/material.dart';

class CommentButton extends StatelessWidget {
  final void Function()? onTap;
  final int commentCount;
  const CommentButton(
      {super.key, required this.onTap, required this.commentCount});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(children: [
        Icon(Icons.comment,
            color: Theme.of(context).colorScheme.secondary, size: 24),
        Text(commentCount.toString(),
            style: TextStyle(color: Theme.of(context).colorScheme.secondary))
      ]),
    );
  }
}
