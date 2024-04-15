import 'package:flutter/material.dart';

import '../../date_time_picker.dart';
import '../../input_text.dart';

class InputTask extends StatelessWidget {
  const InputTask({
    super.key,
    required this.saveTitle,
    required this.saveContent,
    required this.saveStartTime,
    required this.saveEndTime,
    required this.start,
    required this.end,
    required this.date,
    this.saveDate,
  });

  final void Function(String?)? saveTitle;
  final void Function(String?)? saveContent;
  final void Function()? saveStartTime;
  final void Function()? saveEndTime;
  final void Function()? saveDate;
  final TextEditingController date;
  final TextEditingController start;
  final TextEditingController end;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
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
        MyDatePicker(
          icon: Icons.access_time_outlined,
          labelText: 'وقت الانتهاء',
          onTap: saveEndTime,
          controller: end,
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
