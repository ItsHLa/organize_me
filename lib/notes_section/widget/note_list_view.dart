import 'package:flutter/material.dart';

import 'note_item.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric( horizontal: 16),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 100,
        itemBuilder: (context, index) {
          return const TaskItem();
        },
      ),
    );
  }
}