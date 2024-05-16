import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';

class InputText extends StatelessWidget {
  const InputText({
    super.key,
    this.save,
    this.keyboardType,
    this.validator,
    this.labelText,
    this.readOnly,
    this.onTap,
    this.controller,
  });

  final void Function(String?)? save;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? labelText;
  final bool? readOnly;
  final Function()? onTap;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly ?? false,
      keyboardType: keyboardType,
      onSaved: save,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: appColorTheme),
        hintStyle: TextStyle(color: appColorTheme),
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
    );
  }
}
