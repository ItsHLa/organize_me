import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/my_button.dart';

import 'input_task.dart';

class TaskDataPageForm extends StatelessWidget {
  const TaskDataPageForm(
      {super.key,
      this.saveTitle,
      this.saveContent,
      this.saveStartTime,
      this.saveDate,
      this.savePreAlarm,
      required this.date,
      required this.start,
      required this.icon,
      required this.label,
      required this.onPressed,
      this.taskTitleValidator,
      this.contentValidator,
      this.datValidator,
      this.startTimeValidator,
      this.preAlarmValidator});

  final void Function(String?)? saveTitle;
  final void Function(String?)? saveContent;
  final void Function(String?)? savePreAlarm;
  final void Function()? saveStartTime;

  final void Function()? saveDate;
  final TextEditingController date;
  final TextEditingController start;
  final String? Function(String?)? taskTitleValidator;
  final String? Function(String?)? contentValidator;
  final String? Function(String?)? datValidator;
  final String? Function(String?)? startTimeValidator;
  final String? Function(String?)? preAlarmValidator;
  final IconData icon;
  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(
        top: 8.0,
        left: 8,
        right: 8,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      children: [
        Column(
          children: [
            InputTask(
              taskTitleValidator: taskTitleValidator,
              contentValidator: contentValidator,
              startTimeValidator: startTimeValidator,
              datValidator: datValidator,
              preAlarmValidator: preAlarmValidator,
              date: date,
              start: start,
              savePreAlarm: savePreAlarm,
              saveStartTime: saveStartTime,
              saveContent: saveContent,
              saveTitle: saveTitle,
              key: key,
              saveDate: saveDate,
            ),
            MyButton(
              onPressed: onPressed,
              icon: icon,
              label: label,
            )
          ],
        ),
      ],
    );
  }
}
