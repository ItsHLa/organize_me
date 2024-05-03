import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/task_section/cubit/task_cubit.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/add_edit_page_form.dart';
import 'package:organize_me/services/functionality.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String? taskTitle;

  String? taskContent;

  TimeOfDay? start;
  DateTime? date;
  String dateTime = '';

  String startTime = '';
  int? preAlarm;

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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.msg),
                duration: const Duration(minutes: 1),
              ),
            );
          }
        },
        child: Form(
          key: taskKey,
          autovalidateMode: autoValidated,
          child: TaskDataPageForm(
            contentValidator: ValidateInputData.checkIfNull,
            taskTitleValidator: ValidateInputData.checkIfNull,
            datValidator: ValidateInputData.checkDateTime,
            startTimeValidator: (value) {
              return ValidateInputData.checkStartTime(value, dateTime);
            },
            preAlarmValidator: (value) {
              return ValidateInputData.checkTaskInterval(
                  value, startTime, dateTime);
            },
            saveDate: () async {
              date = await showDate(context);
              setState(
                () {
                  if (date != null) {
                    dateTime = '${date!.day}/${date!.month}/${date!.year}';
                  }
                },
              );
            },
            date: TextEditingController(text: dateTime),
            saveTitle: (value) {
              taskTitle = value ?? '';
            },
            saveContent: (value) {
              taskContent = value ?? '';
            },
            saveStartTime: () async {
              start = await showTime(context);
              setState(
                () {
                  if (start != null) {
                    startTime = '${start!.hour}:${start!.minute}';
                  }
                },
              );
            },
            savePreAlarm: (value) {
              setState(
                () {
                  preAlarm = int.parse(value ?? '0');
                },
              );
            },
            start: TextEditingController(text: startTime),
            onPressed: () {
              if (ValidateInputData.validateField(taskKey)) {
                taskKey.currentState!.save();
                BlocProvider.of<TaskCubit>(context).addTask(
                  content: taskContent!,
                  title: taskTitle!,
                  startDate: date!,
                  preAlarm: preAlarm!,
                  startTime: start!,
                );
              } else {
                autoValidated = AutovalidateMode.always;
              }
            },
            icon: Icons.add_task_outlined,
            label: 'اضافة المهمة',
          ),
        ),
      ),
    );
  }
}
