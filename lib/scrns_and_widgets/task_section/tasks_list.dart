import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/task_section/cubit/task_cubit.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/task_list_view.dart';

class Tasks extends StatelessWidget {
  const Tasks({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TaskCubit>(context).loadTasks();
    return BlocBuilder<TaskCubit, TaskState>(builder: (context, state) {
      if (state is LoadingTasks) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is TaskLoaded ||
          state is AddTaskSuccess ||
          state is DeleteTaskSuccess && state.tasks.isNotEmpty) {
        return const TaskListView(
          Tasks: [],
        );
      } else if (state is DeleteTaskSuccess && state.tasks.isEmpty) {
        return const Center(
          child: Text(
            "ليس لديك مهام بعد",
            style: TextStyle(fontSize: 20),
          ),
        );
      }
      return const Center(
        child: Text(
          "ليس لديك مهام بعد",
          style: TextStyle(fontSize: 20),
        ),
      );
    });
  }
}
