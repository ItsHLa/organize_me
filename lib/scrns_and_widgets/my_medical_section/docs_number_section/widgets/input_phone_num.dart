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
          keyboardType: TextInputType.phone,
          hint: 'الرقم',
          save: savePhoneNumber,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'هذا الحقل لا يمكن ان يكون فارغ';
            }

            int phoneNumber = int.parse(value!);
            if (phoneNumber.isNegative) {
              return 'هذا الحقل لا يمكن ان يكون يحوي اعداد سالبة';
            }

            if (value!.length < 10) {
              return 'هذا الحقل لا يمكن ان يكون اقل من 10 ارقام';
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
