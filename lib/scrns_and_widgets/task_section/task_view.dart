import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/input_task.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/time_line.dart';

import '../app_bar.dart';

class DayCalendar extends StatelessWidget {
  const DayCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.small(
          shape: const StadiumBorder(),
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => const InputTask());
          },
          child: const Icon(Icons.add_task),
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
        ));
  }
}
