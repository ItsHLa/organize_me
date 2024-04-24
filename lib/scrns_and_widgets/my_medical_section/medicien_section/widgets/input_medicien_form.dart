import 'package:flutter/material.dart';

import '../../../date_time_picker.dart';
import '../../../input_text.dart';

class MedsInput extends StatelessWidget {
  const MedsInput({
    super.key,
    required this.saveMedName,
    required this.saveMedInterval,
    required this.saveMedShotTime,
    required this.shotTime,
  });

  final void Function(String?)? saveMedName;
  final void Function(String?)? saveMedInterval;
  final void Function()? saveMedShotTime;
  final TextEditingController shotTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        InputText(
          hint: 'اسم الدواء',
          save: saveMedName,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'هذا الحقل لا يمكن ان يكون فارغ';
            } else {
              return '';
            }
          },
        ),
        const SizedBox(
          height: 6,
        ),
        InputText(
          hint: 'عدد الساعات بين الجرعات',
          keyboardType: TextInputType.number,
          save: saveMedInterval,
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
          height: 6,
        ),
        MyDatePicker(
          icon: Icons.access_time_outlined,
          labelText: 'موعد اخذ الدواء',
          onTap: saveMedShotTime,
          controller: shotTime,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'هذا الحقل لا يمكن ان يكون فارغ';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 6,
        ),
      ],
    );
  }
}
