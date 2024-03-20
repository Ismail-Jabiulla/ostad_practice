import 'package:flutter/material.dart';

class ShowAlertDialog extends StatelessWidget {
  const ShowAlertDialog({
    super.key,
    required this.onTapButton,
  });

  final VoidCallback onTapButton;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirm Delete"),
      content: const Text("Are you sure you want to delete this item?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel", style: TextStyle(color: Colors.green),),
        ),
        TextButton(
          onPressed: () {
            onTapButton();
            Navigator.of(context).pop();
          },
          child: const Text("Delete", style: TextStyle(color: Colors.red),),
        ),
      ],
    );
  }
}