import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/task_section/models/task.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/time_line.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key, required this.tasks});

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return MyTimeLine(
          taskTitle: tasks[index].title,
          taskContent: tasks[index].content,
          taskTag: tasks[index].tag,
          // task2Type: 'task2',
          // task2Description: 'task2Description',
        );
      },
    );
  }
}
