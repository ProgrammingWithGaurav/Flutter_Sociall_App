import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  const MyListTile({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

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
          title: Text(title,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary)),
          subtitle: Text(subtitle,
              style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
        ),
      ),
    );
  }
}
