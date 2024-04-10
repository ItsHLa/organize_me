import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.taskTitle,
    required this.taskContent,
    this.taskTag,
    required this.TaskStartTime,
    required this.TaskEndTime,
    this.onPressedEdit,
    this.onPressedDelete,
  });

  final String taskTitle;
  final String taskContent;
  final String? taskTag;
  final String TaskStartTime;
  final String TaskEndTime;
  final void Function()? onPressedEdit;
  final void Function()? onPressedDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
            child: ExpansionTile(
              subtitle: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white10),
                  child: Text('$TaskStartTime - $TaskEndTime')),
              //trailing:  IconButton(onPressed: null, icon: Icon(Icons.check_circle_outline)),
              shape: const StadiumBorder(),
              title: Text(taskTitle),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Spacer(),
                    IconButton(
                        onPressed: onPressedEdit, icon: const Icon(Icons.edit)),
                    IconButton(
                        onPressed: onPressedDelete,
                        icon: const Icon(Icons.delete)),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
