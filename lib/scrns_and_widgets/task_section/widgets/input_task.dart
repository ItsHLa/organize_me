import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/task_section/models/task.dart';

import '../../date_time_picker.dart';
import '../../input_text.dart';

class InputTask extends StatefulWidget {
  const InputTask({super.key, this.logic, this.task});

  final void Function({
    int? id,
    String? title,
    String? tag,
    String? content,
    String? startTime,
    String? endTime,
  })? logic;
  final Task? task;

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
                  start.text = '${startTime.hour}:${startTime.minute}';
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
                  end.text = "${endTime.hour}:${endTime.minute}";
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
                  bool thereEmpty = taskTitle.isEmpty ||
                      taskContent.isEmpty ||
                      start.text.isEmpty ||
                      end.text.isEmpty;
                  bool allEmpty = taskTitle.isEmpty &&
                      taskContent.isEmpty &&
                      start.text.isEmpty &&
                      end.text.isEmpty;
                  if ((widget.task == null && thereEmpty) ||
                      (widget.task != null && allEmpty)) {
                    InputText.validateField(taskKey);
                    return;
                  }
                  widget.logic!(
                    id: widget.task!.id,
                    title: taskTitle,
                    tag: taskTag,
                    content: taskContent,
                    startTime: start.text,
                    endTime: end.text,
                  );
                },
                child:
                    Text(widget.task == null ? 'اضافة المهمة' : 'تعديل المهمة'),
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
