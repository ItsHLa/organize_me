import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  const InputText({super.key, required this.hint, this.lines = 1, this.save, this.maxLength});
  final String hint;
  final int lines;
  final void Function(String?)? save;
  final int? maxLength;

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: widget.save,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'هذا الحقل لايمكن ان يكون فارغ';
        } else {
          return null;
        }
      },
      maxLength: widget.maxLength,
      maxLines: widget.lines,
      decoration: InputDecoration(
        hintText: widget.hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.black12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.black12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.black12),
        ),
      ),
    );
  }
}
