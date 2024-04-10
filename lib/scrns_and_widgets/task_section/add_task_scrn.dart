import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/task_section/cubit/task_cubit.dart';

import 'widgets/input_task.dart';

class AddTaskScrn extends StatefulWidget {
  const AddTaskScrn({super.key});

  @override
  State<AddTaskScrn> createState() => _AddTaskScrnState();
}

class _AddTaskScrnState extends State<AddTaskScrn> {
  TextEditingController start = TextEditingController();
  TextEditingController end = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is AddTaskSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: InputTask(
        logic: ({
          int? id,
          String? title,
          String? tag,
          String? content,
          String? startTime,
          String? endTime,
        }) {
          BlocProvider.of<TaskCubit>(context).addTask(
            title!,
            tag!,
            content!,
            startTime!,
            endTime!,
          );
        },
      ),
    );
  }
}
