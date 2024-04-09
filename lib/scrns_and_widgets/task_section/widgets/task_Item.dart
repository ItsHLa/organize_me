import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem(
      {super.key,
      required this.taskType,
      required this.description,
      this.onPressed});

  final String taskType;
  final String description;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        trailing: IconButton(
          icon: const Icon(Icons.check_circle_outline),
          onPressed: onPressed,
        ),
        shape: const StadiumBorder(),
        title: Text(taskType),
        subtitle: Container(
          padding: const EdgeInsets.all(8),
          child: Text(description),
        ));
  }
}
