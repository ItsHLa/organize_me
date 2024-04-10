import 'package:flutter/material.dart';

import '../../date_time_picker.dart';
import '../../input_text.dart';

class InputTask extends StatefulWidget {
  const InputTask({super.key, this.logic});

  final void Function(String, String?, String, String, String)? logic;

  @override
  State<InputTask> createState() => _InputTaskState();
}

class _InputTaskState extends State<InputTask> {
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  GlobalKey<FormState> taskKey = GlobalKey<FormState>();
  TextEditingController start = TextEditingController();
  TextEditingController end = TextEditingController();
  String? taskTag;
  String taskContent = '';
  String taskTitle = '';
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          right: 9,
          left: 9,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Form(
          autovalidateMode: autoValidate,
          key: taskKey,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              InputText(
                hint: 'عنوان المهمة',
                save: (value) {
                  taskTitle = value ?? '';
                },
              ),
              InputText(
                hint: 'نوع المهمة',
                save: (value) {
                  taskTag = value ?? '';
                },
              ),
              InputText(
                hint: 'وصف المهمة',
                save: (value) {
                  taskContent = value ?? '';
                },
              ),
              const SizedBox(
                height: 5,
              ),
              MyDatePicker(
                labelText: 'وقت البدء',
                onTap: () async {
                  startTime = (await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ))!;
                  start.text = '${startTime.hour} : ${startTime.minute}';
                },
                controller: start,
              ),
              const SizedBox(
                height: 5,
              ),
              MyDatePicker(
                labelText: 'وقت الانتهاء',
                onTap: () async {
                  endTime = (await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ))!;
                  end.text = "${endTime.hour} : ${endTime.minute}";
                },
                controller: end,
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: () async {
                  taskKey.currentState?.save();
                  autoValidate = AutovalidateMode.always;
                  if (taskTitle.isEmpty ||
                      taskContent.isEmpty ||
                      start.text.isEmpty ||
                      end.text.isEmpty) {
                    InputText.validateField(taskKey);
                    return;
                  }
                  widget.logic!(
                    taskTitle,
                    taskTag,
                    taskContent,
                    start.text,
                    end.text,
                  );
                },
                child: const Text('اضافة المهمة'),
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
