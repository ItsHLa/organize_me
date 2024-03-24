import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  const InputText({super.key, required this.hint, this.lines = 1, this.save});
  final String hint;
  final int lines;
  final void Function(String?)? save;

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
          return 'This Field Can not be Empty';
        } else {
          return null;
        }
      },
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
