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
  DateTime? date = DateTime.now();
  String dateTime = '';
  AutovalidateMode autoValidated = AutovalidateMode.disabled;
  GlobalKey<FormState> taskKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskCubit, TaskState>(
      listener: (modalcontext, state) {
        if (state is AddTaskSuccess) {
          Navigator.of(modalcontext).pop();
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
                  saveDate: () async {
                    date = (await showDatePicker(
                          context: context,
                          firstDate: DateTime(2024),
                          lastDate: DateTime(3000),
                        )) ??
                        DateTime.now();
                    setState(() {
                      if (date?.day != null) {
                        dateTime = '${date?.day}/${date?.month}/${date?.year}';
                      }
                    });
                  },
                  date: TextEditingController(text: dateTime),
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
                        )) ??
                        TimeOfDay.now();
                    setState(() {
                      if (editedStart?.hour != null) {
                        editedStartTime =
                            '${editedStart!.hour}:${editedStart!.minute}';
                      }
                    });
                  },
                  saveEndTime: () async {
                    editedEnd = (await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        )) ??
                        TimeOfDay.now();
                    setState(() {
                      if (editedEnd?.hour != null) {
                        editedEndTime =
                            '${editedEnd!.hour}:${editedEnd!.minute}';
                      }
                    });
                  },
                  start: TextEditingController(text: editedStartTime),
                  end: TextEditingController(text: editedEndTime),
                ),
                MyButton(
                    onPressed: () {
                      taskKey.currentState!.save();
                      BlocProvider.of<TaskCubit>(context).editTask(
                          id: widget.task.id,
                          title: editedTaskTitle,
                          content: editedTaskContent,
                          dateTime: date!,
                          startTime: editedStart!,
                          endTime: editedEnd!);
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
