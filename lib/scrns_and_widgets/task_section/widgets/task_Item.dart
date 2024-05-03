import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.taskTitle,
    required this.taskStartTime,
    required this.taskPreAlarm,
    required this.onTap,
    required this.date,
    required this.onStatusIconPressed,
    required this.statusIcon,
    this.onCancelIconPressed,
    required this.cancelIcon,
  });

  final String taskTitle;
  final String taskStartTime;
  final int taskPreAlarm;
  final String date;
  final void Function()? onStatusIconPressed;
  final void Function()? onCancelIconPressed;
  final Widget cancelIcon;
  final Widget statusIcon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ListTile(
                onTap: onTap,
                title: Text(taskTitle),
                subtitle: Text("$taskStartTime - $taskPreAlarm \n $date "),
              ),
            ),
            MyStatusButton(
              onPressed: onStatusIconPressed,
              icon: statusIcon,
            ),
            MyStatusButton(
              onPressed: onCancelIconPressed,
              icon: cancelIcon,
            )
          ],
        ),
        const Divider()
      ],
    );
  }
}

class MyStatusButton extends StatelessWidget {
  const MyStatusButton({
    super.key,
    this.onPressed,
    required this.icon,
  });

  final void Function()? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 30,
      onPressed: onPressed,
      icon: icon,
    );
  }
}
