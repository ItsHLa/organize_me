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
        InputText(
          hint: 'اسم المهمة',
          save: saveTitle,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'هذا الحقل لا يمكن ان يكون فارغ';
            } else {
              return null;
            }
          },
        ),
        const SizedBox(
          height: 5,
        ),
        InputText(
          hint: 'وصف المهمة',
          save: saveContent,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'هذا الحقل لا يمكن ان يكون فارغ';
            } else {
              return null;
            }
          },
        ),
        const SizedBox(
          height: 5,
        ),
        MyDatePicker(
          icon: Icons.date_range,
          labelText: ' تاريخ المهمة',
          onTap: saveDate,
          controller: date,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'هذا الحقل لا يمكن ان يكون فارغ';
            }

            DateTime currentDate = DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day);
            List<String>? parts = value?.split('/');
            print(parts);
            int year = int.parse(parts![2]);
            int month = int.parse(parts![1]);
            int day = int.parse(parts![0]);
            DateTime date = DateTime(year, month, day);
            print(date);
            print(currentDate);
            if (date.isBefore(currentDate.toUtc())) {
              return 'لا يمكن ان يكون اليوم قبل اليوم الحالي';
            }
          },
        ),
        const SizedBox(
          height: 5,
        ),
        MyDatePicker(
          icon: Icons.access_time_outlined,
          labelText: 'وقت البدء',
          onTap: saveStartTime,
          controller: start,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'هذا الحقل لا يمكن ان يكون فارغ';
            }

            List<String>? parts = value?.split(':');
            int hour = int.parse(parts![0]);
            int minute = int.parse(parts![1]);
            DateTime currentTime = DateTime.now();
            DateTime scheduledTime = DateTime(DateTime.now().year,
                DateTime.now().month, DateTime.now().day, hour, minute);
            Duration difference = scheduledTime.difference(currentTime);
            if (difference.isNegative) {
              return 'لا يمكن ان يكون الوقت المختار اقل من الوقت الحالي';
            }
          },
        ),
        const SizedBox(
          height: 5,
        ),
        InputText(
          keyboardType: TextInputType.number,
          hint: 'ذكرني قبل دقائق',
          save: saveRemindMeBefore,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'هذا الحقل لا يمكن ان يكون فارغ';
            }

            int interval = int.parse(value!);
            if (interval.isNegative) {
              return 'هذا الحقل لا يمكن ان يكون يحوي اعداد سالبة';
            } else {
              return null;
            }
          },
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
