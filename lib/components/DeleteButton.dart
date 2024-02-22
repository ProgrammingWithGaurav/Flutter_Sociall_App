import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final void Function()? onPressed;

  DeleteButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: GestureDetector(
        onTap: onPressed,
        child:
            Icon(Icons.cancel, color: Theme.of(context).colorScheme.secondary),
      ),
    );
  }
}
