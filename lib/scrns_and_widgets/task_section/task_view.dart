import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:organize_me/scrns_and_widgets/floating_action_button.dart';
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
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: MyFab(
        //   icon: ,
        children: [
          SpeedDialChild(
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (newcontext) => BlocProvider<TaskCubit>.value(
                    value: BlocProvider.of(context),
                    child: const AddTaskScreen(),
                  ),
                );
              },
              child: const Icon(Icons.add_task)),
          //   SpeedDialChild(
          //      child: const Icon(Icons.note_alt),
          //     onTap: () {
          //      Navigator.of(context).push(MaterialPageRoute(
          //       builder: (context) => const NoteView(),
          //    ));
          // })
        ],
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
