import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/input_task.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/time_line.dart';

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
                builder: (context) => InputTask());
          },
          child: const Icon(Icons.add_task),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return const MyTimeLine();
          },
        ));
  }
}
