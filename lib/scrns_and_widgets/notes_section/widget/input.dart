import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../input_text.dart';

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
      padding:  EdgeInsets.only(left: 10 , right: 10 ,bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Form(
        autovalidateMode: validateMode,
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
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
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
