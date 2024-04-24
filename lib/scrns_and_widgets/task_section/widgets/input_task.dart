import 'package:flutter/material.dart';

import '../../date_time_picker.dart';
import '../../input_text.dart';

class InputTask extends StatelessWidget {
  const InputTask({
    super.key,
    required this.saveTitle,
    required this.saveContent,
    required this.saveStartTime,
    required this.start,
    required this.date,
    this.saveDate,
    this.saveRemindMeBefore,
  });

  final void Function(String?)? saveTitle;
  final void Function(String?)? saveContent;
  final void Function()? saveStartTime;
  final void Function(String?)? saveRemindMeBefore;
  final void Function()? saveDate;
  final TextEditingController date;
  final TextEditingController start;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        InputText(hint: 'اسم المهمة', save: saveTitle),
        const SizedBox(
          height: 5,
        ),
        InputText(hint: 'وصف المهمة', save: saveContent),
        const SizedBox(
          height: 5,
        ),
        MyDatePicker(
          icon: Icons.date_range,
          labelText: ' تاريخ المهمة',
          onTap: saveDate,
          controller: date,
        ),
        const SizedBox(
          height: 5,
        ),
        MyDatePicker(
          icon: Icons.access_time_outlined,
          labelText: 'وقت البدء',
          onTap: saveStartTime,
          controller: start,
        ),
        const SizedBox(
          height: 5,
        ),
        InputText(
          keyboardType: TextInputType.number,
          hint: 'ذكرني قبل دقائق',
          save: saveRemindMeBefore,
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
