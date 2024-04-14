import 'package:flutter/material.dart';

import '../../../date_time_picker.dart';
import '../../../input_text.dart';

class MedsInput extends StatelessWidget {
  const MedsInput(
      {super.key,
      required this.saveMedName,
      required this.saveMedDoses,
      required this.saveMedsTime,
      required this.timeOfDoses});

  final void Function(String?)? saveMedName;
  final void Function(String?)? saveMedDoses;
  final void Function()? saveMedsTime;
  final TextEditingController timeOfDoses;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        InputText(hint: 'اسم الدواء', save: saveMedName),
        const SizedBox(
          height: 6,
        ),
        InputText(
            hint: 'عدد جرعات',
            keyboardType: TextInputType.number,
            save: saveMedDoses),
        const SizedBox(
          height: 6,
        ),
        MyDatePicker(
          icon: Icons.access_time_outlined,
          labelText: 'موعد اخذ الدواء',
          onTap: saveMedsTime,
          controller: timeOfDoses,
        ),
        const SizedBox(
          height: 6,
        ),
      ],
    );
  }
}
