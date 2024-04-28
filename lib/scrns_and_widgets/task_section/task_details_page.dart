import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';

import 'models/task.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({
    super.key,
    this.onPressedEdit,
    required this.task,
  });

  final void Function()? onPressedEdit;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: onPressedEdit, child: const Text('تعديل')),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: softDarkBlue,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: <Widget>[
            Column(
              children: [
                Center(
                  child: ListTile(
                    leading: taskPending,
                    title: Text(
                      task.title,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 170,
                      child: TaskInfo(
                        title: 'تاريخ البدء',
                        text: task.startDate,
                      ),
                    ),
                    SizedBox(
                      width: 170,
                      child: TaskInfo(
                        title: 'توقيت البدء',
                        text: task.startTime,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                TaskInfo(
                  title: 'الحالة',
                  text: task.status,
                ),
                const SizedBox(
                  height: 5,
                ),
                TaskInfo(
                  title: 'الوصف',
                  text: task.content,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TaskInfo extends StatelessWidget {
  const TaskInfo({super.key, required this.text, required this.title});

  final String text;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: const TextStyle(color: Colors.black)),
      subtitle: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: black)),
          child: Text(text,
              style: const TextStyle(fontSize: 15, color: Colors.black)),
        ),
      ),
    );
  }
}
