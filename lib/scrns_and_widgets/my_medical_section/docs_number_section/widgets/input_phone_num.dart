import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/input_text.dart';

class InputPhoneNumber extends StatelessWidget {
  const InputPhoneNumber({
    super.key,
    required this.saveName,
    this.savePhoneNumber,
  });

  final Function(String?)? saveName;

  final Function(String?)? savePhoneNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        InputText(
          hint: 'الاسم',
          save: saveName,
        ),
        const SizedBox(
          height: 5,
        ),
        InputText(
          keyboardType: TextInputType.phone,
          hint: 'الرقم',
          save: savePhoneNumber,
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
