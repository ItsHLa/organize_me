import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';

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
    required this.done,
  });

  final String taskTitle;
  final String taskStartTime;
  final int taskPreAlarm;
  final bool done;
  final String date;
  final void Function()? onStatusIconPressed;
  final void Function()? onCancelIconPressed;
  final Widget cancelIcon;
  final Widget statusIcon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MyStatusButton(
          onPressed: onCancelIconPressed,
          icon: cancelIcon,
        ),
        Expanded(
          child: ListTile(
            onTap: onTap,
            title: Text(
              textAlign: TextAlign.right,
              taskTitle,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  taskStartTime,
                  textAlign: TextAlign.right,
                ),
                Text(
                  date,
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 80,
          width: 10,
          decoration: BoxDecoration(
              color: done ? green : appColorTheme,
              borderRadius: BorderRadius.circular(20)),
        ),
        MyStatusButton(
          onPressed: onStatusIconPressed,
          icon: statusIcon,
        ),
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
