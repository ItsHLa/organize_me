import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/task_cubit.dart';
import 'models/task.dart';
import 'widgets/input_task.dart';

class EditTaskScrn extends StatelessWidget {
  const EditTaskScrn({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is AddTaskSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: InputTask(
        logic: (title, tag, content, startTime, endTime) {
          BlocProvider.of<TaskCubit>(context).editTask();
        },
      ),
    );
  }
}
