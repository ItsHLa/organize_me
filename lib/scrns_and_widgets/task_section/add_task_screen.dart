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
  TimeOfDay end = TimeOfDay.now();
  DateTime date = DateTime.now();
  String dateTime = '';
  String startTime = '';
  int remindMeBefore = 0;
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
                saveRemindMeBefore: (value) {
                  setState(() {
                    remindMeBefore = int.parse(value!);
                  });
                },
                start: TextEditingController(text: startTime),
                onPressed: () {
                  if (taskKey.currentState!.validate()) {
                    taskKey.currentState!.save();
                    BlocProvider.of<TaskCubit>(context).addTask(
                      taskTitle,
                      taskContent,
                      date,
                      start,
                      end,
                      remindMeBefore,
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
