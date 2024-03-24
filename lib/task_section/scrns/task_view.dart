import 'package:flutter/material.dart';
import '../widget/task_list_view.dart';
import 'add_task.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // const CustomAppBar(),
          const Expanded(child: TaskListView()),
          ElevatedButton.icon(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return const AddTaskScrn();
                    });
              },
              icon: const Icon(Icons.add_task),
              label: const Text('Add Task')),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
