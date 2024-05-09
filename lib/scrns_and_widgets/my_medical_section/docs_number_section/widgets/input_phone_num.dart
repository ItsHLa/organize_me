import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/input_text.dart';

class InputPhoneNumber extends StatelessWidget {
  const InputPhoneNumber({
    super.key,
    required this.saveName,
    required this.savePhoneNumber,
    required this.saveSpecialist,
    this.nameValidator,
    this.specialistValidator,
    this.phoneNumberValidator,
    this.saveClinicNumber,
    this.clinicNumberValidator,
  });

  final Function(String?)? saveName;
  final Function(String?)? saveSpecialist;
  final Function(String?)? saveClinicNumber;
  final Function(String?)? savePhoneNumber;
  final String? Function(String?)? nameValidator;
  final String? Function(String?)? specialistValidator;
  final String? Function(String?)? phoneNumberValidator;
  final String? Function(String?)? clinicNumberValidator;

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
          validator: nameValidator,
        ),
        const SizedBox(
          height: 5,
        ),
        InputText(
          hint: 'الاختصاص',
          save: saveSpecialist,
          validator: specialistValidator,
        ),
        const SizedBox(
          height: 5,
        ),
        InputText(
          keyboardType: TextInputType.phone,
          hint: 'رقم الطبيب',
          save: savePhoneNumber,
          validator: phoneNumberValidator,
        ),
        const SizedBox(
          height: 5,
        ),
        InputText(
          keyboardType: TextInputType.phone,
          hint: 'رقم العيادة',
          save: saveClinicNumber,
          validator: clinicNumberValidator,
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
