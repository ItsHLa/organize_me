import 'package:flutter/material.dart';

import '../../../services/functionality.dart';
import '../../date_time_picker.dart';
import '../../input_text.dart';

class InputTask extends StatelessWidget {
  const InputTask({
    super.key,
    required this.saveTitle,
    required this.saveContent,
    required this.saveStartTime,
    required this.savePreAlarm,
    required this.start,
    required this.date,
    this.saveDate,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        InputText(
          hint: 'اسم المهمة',
          save: saveTitle,
          validator: taskTitleValidator,
        ),
        const SizedBox(
          height: 5,
        ),
        InputText(
          hint: 'وصف المهمة',
          save: saveContent,
          validator: contentValidator,
        ),
        const SizedBox(
          height: 5,
        ),
        MyDatePicker(
          icon: Icons.date_range,
          labelText: ' تاريخ المهمة',
          onTap: saveDate,
          controller: date,
          validator: datValidator,
        ),
        const SizedBox(
          height: 5,
        ),
        MyDatePicker(
          icon: Icons.access_time_outlined,
          labelText: 'وقت البدء',
          onTap: saveStartTime,
          controller: start,
          validator: ValidateInputData.checkStartTime,
        ),
        const SizedBox(
          height: 5,
        ),
        InputText(
          keyboardType: TextInputType.number,
          hint: 'ذكرني قبل دقائق',
          save: savePreAlarm,
          validator: preAlarmValidator,
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
