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
    return Scaffold(
      body: BlocListener<TaskCubit, TaskState>(
        listener: (newcontext, state) {
          if (state is AddTaskSuccess) {
            Navigator.of(newcontext).pop();
          }
        },
        child: Form(
          key: taskKey,
          autovalidateMode: autoValidated,
          child: TaskDataPageForm(
            saveTitle: (value) {
              taskTitle = value ?? '';
            },
            saveContent: (value) {
              taskContent = value ?? '';
            },
            savePreAlarm: (value) {
              preAlarm = int.parse(value ?? '0');
            },
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
            saveStartTime: () async {
              start = (await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  )) ??
                  TimeOfDay.now();
              setState(() {
                startTime = '${start.hour}:${start.minute}';
              });
            },
            start: TextEditingController(text: startTime),
            onPressed: () {
              taskKey.currentState!.save();
              DateTime dateNow = DateTime.now();
              TimeOfDay timeNow = TimeOfDay.now();
              int difInMinutes = ((start.hour - timeNow.hour) * 60 +
                  (start.minute - timeNow.minute));
              if (date.isAfter(dateNow) ||
                  (timeNow.hour > start.hour) ||
                  (timeNow.hour == start.hour &&
                      timeNow.minute > start.minute)) {
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
              } else if ((date.year == dateNow.year &&
                      date.month == dateNow.month &&
                      date.day == dateNow.day) &&
                  difInMinutes <= preAlarm) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      children: [
                        Text(
                          "لن نتمكن من تنبيهك للقيام بمهمة بعد $difInMinutes دقيقة/دقائق قبل $preAlarm دقيقة/دقائق",
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
              } else if (taskKey.currentState!.validate()) {
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
        ),
      ),
    );
  }
}
