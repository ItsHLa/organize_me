import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/my_button.dart';

import 'input_task.dart';

class TaskDataPageForm extends StatelessWidget {
  const TaskDataPageForm(
      {super.key,
      this.saveTitle,
      this.saveContent,
      this.saveStartTime,
      this.saveRemindMeBefore,
      this.saveDate,
      required this.date,
      required this.start,
      //   required this.end,
      required this.icon,
      required this.label,
      this.onPressed});

  final void Function(String?)? saveTitle;
  final void Function(String?)? saveContent;
  final void Function()? saveStartTime;
  final void Function(String?)? saveRemindMeBefore;
  final void Function()? saveDate;
  final TextEditingController date;
  final TextEditingController start;

  // final TextEditingController end;
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
              date: date,
              start: start,
              saveRemindMeBefore: saveRemindMeBefore,
              saveStartTime: saveStartTime,
              saveContent: saveContent,
              saveTitle: saveTitle,
              key: key,
              saveDate: saveDate,
            ),
            MyButton(onPressed: onPressed, icon: icon, label: label)
          ],
        ),
      ],
    );
  }
}
