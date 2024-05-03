import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';

class InputText extends StatelessWidget {
  const InputText({
    super.key,
    required this.hint,
    this.lines = 1,
    this.save,
    this.maxLength,
    this.keyboardType,
    this.validator,
  });

  final String hint;
  final int lines;
  final void Function(String?)? save;
  final int? maxLength;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      onSaved: save,
      validator: validator,
      maxLength: maxLength,
      maxLines: lines,
      decoration: InputDecoration(
        hintText: hint,
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
          borderSide: BorderSide(color: appColorTheme),
        ),
      ),
    );
  }
}
