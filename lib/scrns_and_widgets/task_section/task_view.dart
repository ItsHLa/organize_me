import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/day_view.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const DailyTasks());
  }
}
