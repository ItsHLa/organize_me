import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/task_section/cubit/task_cubit.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/time_line.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key, required this.Tasks});

  final List Tasks;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return MyTimeLine(
              value: true,
              onChange: (v) {},
            );
          },
        );
      },
    );
  }
}
