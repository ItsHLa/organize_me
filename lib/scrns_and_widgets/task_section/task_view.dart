import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/floating_action_button.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/input_task.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/time_line.dart';

import '../app_bar.dart';

class DayCalendar extends StatelessWidget {
  const DayCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyFab(
        icon: Icons.add_task,
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => const InputTask(),
          );
        },
      ),
      body: Column(
        children: [
          const MAppBar(),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return const MyTimeLine();
              },
            ),
          ),
        ],
      ),
    );
  }
}
