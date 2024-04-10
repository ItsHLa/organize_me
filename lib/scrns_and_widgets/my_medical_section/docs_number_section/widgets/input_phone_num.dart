import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/input_text.dart';

class InputPhoneNumber extends StatefulWidget {
  const InputPhoneNumber({super.key, required this.onPressed});

  final void Function(GlobalKey<FormState>, String, String) onPressed;

  @override
  State<InputPhoneNumber> createState() => _AddNumberState();
}

class _AddNumberState extends State<InputPhoneNumber> {
  String newName = '';
  String newPhone = '';
  GlobalKey<FormState> numKey = GlobalKey();
  AutovalidateMode validateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 8,
        right: 8,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Form(
          autovalidateMode: validateMode,
          key: numKey,
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              InputText(
                hint: 'الاسم',
                save: (value) {
                  newName = value ?? '';
                },
              ),
              const SizedBox(
                height: 5,
              ),
              InputText(
                hint: 'الرقم',
                save: (value) {
                  newPhone = value ?? '';
                },
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: () {
                  validateMode = AutovalidateMode.always;
                  numKey.currentState!.save();
                  widget.onPressed(numKey, newName, newPhone);
                },
                child: const Icon(Icons.add),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
