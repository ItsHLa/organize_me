import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.taskTitle,
    required this.taskContent,
    this.taskTag,
    this.onPressed,
  });

  final String taskTitle;
  final String taskContent;
  final String? taskTag;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: IconButton(
        icon: const Icon(Icons.check_circle_outline),
        onPressed: onPressed,
      ),
      shape: const StadiumBorder(),
      title: Text(taskTitle),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: Text(taskContent),
          ),
          taskTag != null
              ? Container(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(taskTag!),
                )
              : Container(),
        ],
      ),
    );
  }
}
