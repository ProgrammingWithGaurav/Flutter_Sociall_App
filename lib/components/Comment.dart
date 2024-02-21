import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final String text;
  final String user;
  final String time;
  const Comment(
      {super.key, required this.text, required this.user, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(4)),
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          // comment
          Text(text),

          // user, time
          Row(children: [
            Text(
              user,
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
            Text(" • ",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary)),
            Text(time,
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary)),
          ]),
        ],
      ),
    );
  }
}
