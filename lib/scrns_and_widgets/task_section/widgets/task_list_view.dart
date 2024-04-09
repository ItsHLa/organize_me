import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/time_line.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key, required this.Tasks});

  final List Tasks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return const MyTimeLine(
          task1Type: 'task1',
          task1Description: 'task1Description',
          task2Type: 'task2',
          task2Description: 'task2Description',
        );
      },
    );
  }
}
