import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/task_cubit.dart';
import 'widgets/input_task.dart';

class EditTaskScrn extends StatefulWidget {
  const EditTaskScrn({super.key});

  @override
  State<EditTaskScrn> createState() => _EditTaskScrnState();
}

class _EditTaskScrnState extends State<EditTaskScrn> {
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
