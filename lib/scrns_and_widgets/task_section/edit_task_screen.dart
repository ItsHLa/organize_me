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
  TimeOfDay? editedStart;
  String editedStartTime = '';
  int editedPreAlarm = 0;
  DateTime? date;
  String dateTime = '';
  AutovalidateMode autoValidated = AutovalidateMode.disabled;
  GlobalKey<FormState> taskKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskCubit, TaskState>(
        listener: (newcontext, state) {
          if (state is AddTaskSuccess) {
            Navigator.of(newcontext).pop();
          }
        },
        child: Form(
          key: taskKey,
          child: TaskDataPageForm(
            preAlarmValidator: (value) {
              int interval = int.parse(value!);
              if (interval.isNegative) {
                return 'هذا الحقل لا يمكن ان يكون يحوي اعداد سالبة';
              } else {
                return null;
              }
            },
            datValidator: (value) {
              DateTime currentDate = DateTime(DateTime.now().year,
                  DateTime.now().month, DateTime.now().day);
              List<String>? parts = value?.split('/');
              int year = int.parse(parts![2]);
              int month = int.parse(parts[1]);
              int day = int.parse(parts[0]);
              DateTime date = DateTime(year, month, day);
              if (date.isBefore(currentDate.toUtc())) {
                return 'لا يمكن ان يكون اليوم قبل اليوم الحالي';
              } else {
                return null;
              }
            },
            startTimeValidator: (value) {
              List<String>? parts = value?.split(':');
              int hour = int.parse(parts![0]);
              int minute = int.parse(parts[1]);
              DateTime currentTime = DateTime.now();
              DateTime scheduledTime = DateTime(DateTime.now().year,
                  DateTime.now().month, DateTime.now().day, hour, minute);
              Duration difference = scheduledTime.difference(currentTime);
              if (difference.isNegative) {
                return 'لا يمكن ان يكون الوقت المختار اقل من الوقت الحالي';
              } else {
                return null;
              }
            },
            saveDate: () async {
              date = (await showDatePicker(
                context: context,
                firstDate: DateTime(2024),
                lastDate: DateTime(3000),
              ));
              setState(() {
                dateTime = date != null
                    ? '${date!.day}/${date!.month}/${date!.year}'
                    : '';
              });
            },
            date: TextEditingController(text: dateTime),
            saveTitle: (value) {
              editedTaskTitle = value ?? widget.task.title;
            },
            saveContent: (value) {
              editedTaskContent = value ?? widget.task.content;
            },
            saveStartTime: () async {
              editedStart = (await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              ));
              setState(() {
                editedStartTime = editedStart != null
                    ? '${editedStart!.hour}:${editedStart!.minute}'
                    : '';
              });
            },
            savePreAlarm: (value) {
              editedPreAlarm = int.parse(value!.isNotEmpty ? value : '0');
            },
            start: TextEditingController(text: editedStartTime),
            onPressed: () {
              taskKey.currentState?.save();
              BlocProvider.of<TaskCubit>(context).editTask(
                preAlarm: editedPreAlarm,
                id: widget.task.id,
                title: editedTaskTitle,
                content: editedTaskContent,
                startDate: date,
                startTime: editedStart,
              );
            },
            icon: Icons.edit,
            label: 'تعديل المهمة',
          ),
        ));
  }
}
