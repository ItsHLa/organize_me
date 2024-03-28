import 'package:flutter/material.dart';
import 'input_text.dart';

class Input extends StatefulWidget {
  const Input({
    super.key,
    required this.title,
    required this.content,
    required this.action,
    required this.icon,
  });

  final String title;
  final String content;
  final String action;
  final IconData icon;

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  late String? taskName;
  late String? description;
  AutovalidateMode validateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool validate(GlobalKey<FormState> key) {
    if (key.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Form(
        autovalidateMode: validateMode,
        key: formKey,
        child: ListView(
          children: [
            const SizedBox(height: 10),
            InputText(
              hint: widget.title,
              save: (value) {
                taskName = value;
              },
              maxLength: 30,
            ),
            const SizedBox(height: 4),
            InputText(
              hint: widget.content,
              lines: 5,
              save: (value) => description = value,
            ),
            const SizedBox(height: 5),
            ElevatedButton.icon(
              onPressed: () {
                if (validate(formKey)) {
                  formKey.currentState!.save();
                } else {
                  validateMode = AutovalidateMode.always;
                }
                // addTask
              },
              icon: Icon(widget.icon),
              label: Text(widget.action),
            )
          ],
        ),
      ),
    );
  }
}