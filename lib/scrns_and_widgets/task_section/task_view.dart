import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/task_Item.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return TaskItem();
        },
      ),
    );
  }
}
