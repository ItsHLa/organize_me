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
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
            child: ExpansionTile(
              subtitle: Text('start Time - End Time'),
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Spacer(),
                    IconButton(onPressed: null, icon: Icon(Icons.edit)),
                    IconButton(onPressed: null, icon: Icon(Icons.delete)),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
