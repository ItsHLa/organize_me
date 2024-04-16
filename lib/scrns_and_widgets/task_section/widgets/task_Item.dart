import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.taskTitle,
    required this.taskStartTime,
    required this.taskEndTime,
    this.onPressedEdit,
    this.onPressedDelete,
    this.onTap,
  });

  final String taskTitle;
  final String taskStartTime;
  final String taskEndTime;
  final void Function()? onPressedEdit;
  final void Function()? onPressedDelete;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(taskTitle),
      subtitle: Text('$taskStartTime - $taskEndTime'),
    );
  }
}
