import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/floating_action_button.dart';
import 'package:organize_me/scrns_and_widgets/task_section/cubit/task_cubit.dart';
import 'package:organize_me/scrns_and_widgets/task_section/tasks_list.dart';

import '../app_bar.dart';
import 'add_task_scrn.dart';

class DayCalendar extends StatefulWidget {
  const DayCalendar({super.key});

  @override
  State<DayCalendar> createState() => _DayCalendarState();
}

class _DayCalendarState extends State<DayCalendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyFab(
        icon: Icons.add_task,
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (newcontext) => BlocProvider<TaskCubit>.value(
              value: BlocProvider.of(context),
              child: const AddTaskScrn(),
            ),
          );
        },
      ),
      body: const Column(
        children: [
          MAppBar(),
          Expanded(child: Tasks()),
        ],
      ),
    );
  }
}
