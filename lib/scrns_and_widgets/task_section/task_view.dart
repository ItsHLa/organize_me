import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/task_section/cubit/task_cubit.dart';
import 'package:organize_me/scrns_and_widgets/task_section/tasks_list.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/date_time_line.dart';

import 'add_task_screen.dart';

class DayCalendar extends StatefulWidget {
  const DayCalendar({super.key});

  @override
  State<DayCalendar> createState() => _DayCalendarState();
}

class _DayCalendarState extends State<DayCalendar> {
  DateTime focusDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: appColorTheme,
        shape: const StadiumBorder(),
        child: const Icon(
          Icons.add_task,
          color: Colors.white60,
        ),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (newcontext) => BlocProvider<TaskCubit>.value(
              value: BlocProvider.of(context),
              child: const AddTaskScreen(),
            ),
          );
        },
      ),
      body: Column(
        children: [
          MyDateTimeLine(
            onDateChange: (selectedDate) {
              setState(() {
                focusDate = selectedDate;
              });
            },
            focusDate: focusDate,
          ),
          Expanded(
              child: Tasks(
            focusDate: focusDate,
          )),
        ],
      ),
    );
  }
}
