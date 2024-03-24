import 'package:flutter/material.dart';

import '../widget/input.dart';


class AddTaskScrn extends StatelessWidget {
  const AddTaskScrn({super.key});

  @override
  Widget build(BuildContext context) {
    return Input(
      title: 'Task Name',
      content: 'Description',
      action: 'Add Task',
      icon: Icons.add_task,
    );
  }
}
