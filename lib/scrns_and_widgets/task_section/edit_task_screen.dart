import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/my_button.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/input_task.dart';

import 'cubit/task_cubit.dart';
import 'models/task.dart';

class EditTask extends StatefulWidget {
  const EditTask({super.key, required this.task});

  final Task task;

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  String editedTaskTitle = '';
  String editedTaskContent = '';
  TimeOfDay? editedStart = TimeOfDay.now();
  TimeOfDay? editedEnd = TimeOfDay.now();
  String editedStartTime = '';
  String editedEndTime = '';
  AutovalidateMode autoValidated = AutovalidateMode.disabled;
  GlobalKey<FormState> taskKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is AddTaskSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: 8.0,
          left: 8,
          right: 8,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: taskKey,
            child: Column(
              children: [
                InputTask(
                  saveTitle: (value) {
                    editedTaskTitle = value ?? '';
                  },
                  saveContent: (value) {
                    editedTaskContent = value ?? '';
                  },
                  saveStartTime: () async {
                    editedStart = (await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ));
                    setState(() {
                      editedStartTime =
                          '${editedStart!.hour}:${editedStart!.minute}';
                    });
                  },
                  saveEndTime: () async {
                    editedEnd = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    setState(() {
                      editedEndTime = '${editedEnd!.hour}:${editedEnd!.minute}';
                    });
                  },
                  start: TextEditingController(text: editedStartTime),
                  end: TextEditingController(text: editedEndTime),
                ),
                MyButton(
                    onPressed: () {
                      taskKey.currentState!.save();
                      BlocProvider.of<TaskCubit>(context).editTask(
                        widget.task.id,
                        editedTaskTitle,
                        editedTaskContent,
                        editedStartTime,
                        editedEndTime,
                      );
                    },
                    icon: Icons.edit,
                    label: 'تعديل المهمة'),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
