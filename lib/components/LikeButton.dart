import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final bool isLiked;
  final void Function()? onTap;
  final String postId;
  final List<String> likes;
  LikeButton(
      {super.key,
      required this.isLiked,
      required this.onTap,
      required this.postId,
      required this.likes});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(children: [
        Icon(
          widget.isLiked ? Icons.favorite : Icons.favorite_border,
          size: 28,
          color: widget.isLiked
              ? Colors.red
              : Theme.of(context).colorScheme.secondary,
        ),
        const SizedBox(height: 5),
        Text(widget.likes.length.toString(),
            style: TextStyle(color: Theme.of(context).colorScheme.secondary))
      ]),
    );
  }
}
