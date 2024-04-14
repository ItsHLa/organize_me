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
  });

  final void Function(String?)? saveTitle;
  final void Function(String?)? saveContent;
  final void Function()? saveStartTime;
  final void Function()? saveEndTime;
  final TextEditingController start;

  final TextEditingController end;

  //final void Function({
  // int? id,
  // String? title,
  // String? content,
  // String? startTime,
  // String? endTime,
  // })? logic;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        InputText(hint: 'نوع المهمة', save: saveTitle),
        InputText(hint: 'وصف المهمة', save: saveContent),
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
