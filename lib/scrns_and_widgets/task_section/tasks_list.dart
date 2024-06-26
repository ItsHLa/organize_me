import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/task_section/cubit/task_cubit.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/task_list_view.dart';

import '../no_content.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key, required this.focusDate});

  final DateTime focusDate;

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TaskCubit>(context).loadTasks(widget.focusDate);
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (state is LoadingTasks) {
          return Center(
            child: CircularProgressIndicator(
              color: appColorTheme,
            ),
          );
        } else if (state.tasks.isNotEmpty &&
            (state is TaskLoaded ||
                state is AddTaskSuccess ||
                state is DeleteTaskSuccess)) {
          return TaskListView(
            tasks: state.tasks,
          );
        } else {
          return const NoContent(
            text: "ليس لديك مهام بعد",
          );
        }
      },
    );
  }
}
