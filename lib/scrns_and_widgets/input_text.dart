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
    this.labelText,
    this.readOnly,
    this.onTap,
  });

  final String hint;
  final int lines;
  final void Function(String?)? save;
  final int? maxLength;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? labelText;
  final bool? readOnly;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly ?? false,
      keyboardType: keyboardType,
      onSaved: save,
      validator: validator,
      maxLength: maxLength,
      maxLines: lines,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: appColorTheme),
        hintStyle: TextStyle(color: appColorTheme),
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
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
