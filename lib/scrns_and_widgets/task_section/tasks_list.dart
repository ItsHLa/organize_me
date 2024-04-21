import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/task_section/cubit/task_cubit.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/date_time_line.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/task_list_view.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  DateTime focusDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TaskCubit>(context).loadTasks(focusDate);
    return Column(
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
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              if (state is LoadingTasks) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.tasks.isNotEmpty &&
                  (state is TaskLoaded ||
                      state is AddTaskSuccess ||
                      state is DeleteTaskSuccess)) {
                return TaskListView(
                  tasks: state.tasks,
                );
              } else {
                return const Center(
                  child: Text(
                    "ليس لديك مهام بعد",
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
