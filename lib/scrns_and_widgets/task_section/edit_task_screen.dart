import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/add_edit_page_form.dart';

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
  TimeOfDay editedStart = TimeOfDay.now();
  TimeOfDay editedEnd = TimeOfDay.now();
  String editedStartTime = '';
  String editedEndTime = '';
  DateTime date = DateTime.now();
  String dateTime = '';
  AutovalidateMode autoValidated = AutovalidateMode.disabled;
  GlobalKey<FormState> taskKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocListener<TaskCubit, TaskState>(
            listener: (newcontext, state) {
              if (state is AddTaskSuccess) {
                Navigator.of(newcontext).pop();
              }
            },
            child: Form(
              key: taskKey,
              child: TaskDataPageForm(
                saveDate: () async {
                  date = (await showDatePicker(
                        context: context,
                        firstDate: DateTime(2024),
                        lastDate: DateTime(3000),
                      )) ??
                      DateTime.now();
                  setState(() {
                    dateTime = '${date.day}/${date.month}/${date.year}';
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
                    editedStartTime =
                        '${editedStart.hour}:${editedStart.minute}';
                  });
                },
                saveEndTime: () async {
                  editedEnd = (await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      )) ??
                      TimeOfDay.now();
                  setState(() {
                    editedEndTime = '${editedEnd.hour}:${editedEnd.minute}';
                  });
                },
                start: TextEditingController(text: editedStartTime),
                end: TextEditingController(text: editedEndTime),
                onPressed: () {
                  taskKey.currentState?.save();
                  BlocProvider.of<TaskCubit>(context).editTask(
                      id: widget.task.id,
                      title: editedTaskTitle,
                      content: editedTaskContent,
                      dateTime: date,
                      startTime: editedStart,
                      endTime: editedEnd);
                },
                icon: Icons.edit,
                label: 'تعديل المهمة',
              ),
            )));
  }
}
