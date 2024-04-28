import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/task_section/cubit/task_cubit.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/task_list_view.dart';

class Tasks extends StatelessWidget {
  const Tasks({super.key, required this.focusDate});

  final DateTime focusDate;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TaskCubit>(context).loadTasks(focusDate);
    return Column(
      children: [
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
