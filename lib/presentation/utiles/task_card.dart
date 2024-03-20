import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final int value;

  const TaskCard({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width / 3.5,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Text(
              '$value',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
