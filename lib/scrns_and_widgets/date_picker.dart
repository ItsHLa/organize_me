import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';

class MyDatePicker extends StatelessWidget {
  const MyDatePicker(
      {super.key,
      required this.labelText,
      required this.onTap,
      required this.controller,
      this.icon,
      this.validator});

  final String labelText;
  final void Function()? onTap;
  final TextEditingController controller;
  final IconData? icon;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // padding: const EdgeInsets.symmetric(horizontal: 1),
      height: 70,
      child: TextFormField(
        validator: validator,
        controller: controller,
        readOnly: true,
        onTap: onTap,
        decoration: InputDecoration(
          suffixIcon: Icon(
            icon,
            color: appColorTheme,
          ),
          label: Text(labelText),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: appColorTheme),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: appColorTheme),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}