import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.taskTitle,
    required this.taskStartTime,
    required this.taskPreAlarm,
    this.onPressedEdit,
    this.onPressedDelete,
    this.onTap,
    required this.date,
  });

  final String taskTitle;
  final String taskStartTime;
  final int taskPreAlarm;
  final String date;
  final void Function()? onPressedEdit;
  final void Function()? onPressedDelete;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: taskPending,
      onTap: onTap,
      title: Text(taskTitle),
      subtitle: Text("$taskStartTime - $taskPreAlarm \n $date "),
    );
  }
}
