import 'package:flutter/material.dart';
import '../widget/task_list_view.dart';
import 'add_task.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return const AddTaskScrn();
              });
        },
        shape: const StadiumBorder(),
        child: const  Icon(Icons.add_task),
      ),
      body: const Column(
        children: [
           Expanded(child: TaskListView()),

        ],
      ),
    );
  }
}
