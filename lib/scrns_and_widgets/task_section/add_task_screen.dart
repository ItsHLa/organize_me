import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/task_section/cubit/task_cubit.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/add_edit_page_form.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String taskTitle = '';
  String taskContent = '';

  TimeOfDay start = TimeOfDay.now();
  DateTime date = DateTime.now();
  String dateTime = '';
  String startTime = '';
  int preAlarm = 0;
  AutovalidateMode autoValidated = AutovalidateMode.disabled;
  GlobalKey<FormState> taskKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: BlocListener<TaskCubit, TaskState>(
            listener: (newcontext, state) {
              if (state is AddTaskSuccess) {
                Navigator.of(newcontext).pop();
              }
              if (state is AddTaskFailed) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.msg),
                  duration: const Duration(minutes: 1),
                ));
              }
            },
            child: Form(
              key: taskKey,
              autovalidateMode: autoValidated,
              child: TaskDataPageForm(
                contentValidator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'هذا الحقل لا يمكن ان يكون فارغ';
                  } else {
                    return null;
                  }
                },
                taskTitleValidator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'هذا الحقل لا يمكن ان يكون فارغ';
                  } else {
                    return null;
                  }
                },
                datValidator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'هذا الحقل لا يمكن ان يكون فارغ';
                  }

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
                  if (value?.isEmpty ?? true) {
                    return 'هذا الحقل لا يمكن ان يكون فارغ';
                  }

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
                preAlarmValidator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'هذا الحقل لا يمكن ان يكون فارغ';
                  }

                  int interval = int.parse(value!);
                  if (interval.isNegative) {
                    return 'هذا الحقل لا يمكن ان يكون يحوي اعداد سالبة';
                  } else {
                    return null;
                  }
                },
                saveDate: () async {
                  date = (await showDatePicker(
                          context: context,
                          firstDate: DateTime(2024),
                          lastDate: DateTime(3000),
                          initialEntryMode: DatePickerEntryMode.input,
                          errorFormatText: 'خطأ في الصيغة',
                          errorInvalidText:
                              'لا يمكن ان يكون الوقت قبل الوقت الحالي',
                          initialDate: DateTime.now())) ??
                      DateTime.now();
                  setState(() {
                    dateTime = '${date.day}/${date.month}/${date.year}';
                  });
                },
                date: TextEditingController(text: dateTime),
                saveTitle: (value) {
                  taskTitle = value ?? '';
                },
                saveContent: (value) {
                  taskContent = value ?? '';
                },
                saveStartTime: () async {
                  start = (await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      errorInvalidText:
                      'لا يمكن ان يكون اليوم قبل اليوم الحالي')) ??
                      TimeOfDay.now();
                  setState(() {
                    startTime = '${start.hour}:${start.minute}';
                  });
                },
                savePreAlarm: (value) {
                  setState(() {
                    preAlarm = int.parse(value!);
                  });
                },
                start: TextEditingController(text: startTime),
                onPressed: () {
                  if (taskKey.currentState!.validate()) {
                    taskKey.currentState!.save();
                    BlocProvider.of<TaskCubit>(context).addTask(
                      content: taskContent,
                      title: taskTitle,
                      startDate: date,
                      preAlarm: preAlarm,
                      startTime: start,
                    );
                  } else {
                    autoValidated = AutovalidateMode.always;
                  }
                },
                icon: Icons.add_task_outlined,
                label: 'اضافة المهمة',
              ),
            )));
  }
}
