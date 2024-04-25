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
    return Scaffold(
      body: BlocListener<TaskCubit, TaskState>(
        listener: (newcontext, state) {
          if (state is AddTaskSuccess) {
            Navigator.of(newcontext).pop();
          }
        },
        child: Form(
          key: taskKey,
          child: TaskDataPageForm(
            saveTitle: (value) {
              editedTaskTitle = value ?? widget.task.title;
            },
            saveContent: (value) {
              editedTaskContent = value ?? widget.task.content;
            },
            savePreAlarm: (value) {
              editedPreAlarm = int.parse(value!.isNotEmpty ? value : '0');
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
            start: TextEditingController(text: editedStartTime),
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
            onPressed: () {
              taskKey.currentState?.save();
              DateTime dateNow = DateTime.now();
              TimeOfDay timeNow = TimeOfDay.now();
              int? difInMinutes;
              if (editedStart != null) {
                difInMinutes = ((editedStart!.hour - timeNow.hour) * 60 +
                    (editedStart!.minute - timeNow.minute));
              }
              if (date?.isAfter(dateNow) ??
                  false ||
                      (editedStart != null &&
                          ((timeNow.hour > editedStart!.hour) ||
                              (timeNow.hour == editedStart!.hour &&
                                  timeNow.minute > editedStart!.minute)))) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const SimpleDialog(
                      children: [
                        Text(
                          "!وقت البداية يجب أن يكون في المستقبل",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    );
                  },
                );
                return;
              } else if ((date != null &&
                      (date!.year == dateNow.year &&
                          date!.month == dateNow.month &&
                          date!.day == dateNow.day)) &&
                  (difInMinutes != null && difInMinutes <= editedPreAlarm)) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      children: [
                        Text(
                          "لن نتمكن من تنبيهك للقيام بمهمة بعد $difInMinutes دقيقة/دقائق قبل $editedPreAlarm دقيقة/دقائق",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    );
                  },
                );
                return;
              }
              BlocProvider.of<TaskCubit>(context).editTask(
                id: widget.task.id,
                title: editedTaskTitle,
                content: editedTaskContent,
                startDate: date,
                startTime: editedStart,
                preAlarm: editedPreAlarm,
              );
            },
            icon: Icons.edit,
            label: 'تعديل المهمة',
          ),
        ),
      ),
    );
  }
}
