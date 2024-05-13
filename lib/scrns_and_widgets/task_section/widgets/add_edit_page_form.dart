/*
* import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/add_data_page.dart';

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
    this.preAlarmValidator,
  });

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
    return InputDataPage(
        onPressed: onPressed,
        icon: icon,
        labels: label,
        child: InputTask(
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
        ));
  }
}

* */
