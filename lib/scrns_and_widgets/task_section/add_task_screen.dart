import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/my_button.dart';
import 'package:organize_me/scrns_and_widgets/task_section/cubit/task_cubit.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/input_task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String taskTitle = '';
  String taskContent = '';
  String taskTag = '';

  TimeOfDay? start = TimeOfDay.now();
  TimeOfDay? end = TimeOfDay.now();
  DateTime? date = DateTime.now();
  String dateTime = '';
  String startTime = '';
  String endTime = '';
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
          child: Column(
            children: [
              Form(
                key: taskKey,
                autovalidateMode: autoValidated,
                child: InputTask(
                  saveTag: (value) {
                    setState(() {
                      taskTag = value!;
                    });
                  },
                  saveDate: () async {
                    date = (await showDatePicker(
                      context: context,
                      firstDate: DateTime(2024),
                      lastDate: DateTime(3000),
                      initialDate: DateTime.now(),
                    ));
                    setState(() {
                      dateTime = '${date?.day}/${date?.month}/${date?.year}';
                    });
                  },
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
                    ));
                    setState(() {
                      startTime = '${start?.hour}:${start?.minute}';
                    });
                  },
                  saveEndTime: () async {
                    end = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    setState(() {
                      endTime = '${end!.hour}:${end!.minute}';
                    });
                  },
                  start: TextEditingController(text: startTime),
                  end: TextEditingController(text: endTime),
                  Date: TextEditingController(text: dateTime),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MyButton(
                onPressed: () {
                  if (taskKey.currentState!.validate()) {
                    taskKey.currentState!.save();
                    BlocProvider.of<TaskCubit>(context).addTask(
                      taskTitle,
                      taskContent,
                      date!,
                      start!,
                      end!,
                    );
                  } else {
                    autoValidated = AutovalidateMode.always;
                  }
                },
                icon: Icons.add_task_outlined,
                label: 'اضافة المهمة',
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
