import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/input_text.dart';

class InputPhoneNumber extends StatefulWidget {
  const InputPhoneNumber({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  State<InputPhoneNumber> createState() => _AddNumberState();
}

class _AddNumberState extends State<InputPhoneNumber> {
  GlobalKey<FormState> numKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: 8, right: 8, bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Form(
          key: numKey,
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              const InputText(hint: 'الاسم'),
              const SizedBox(
                height: 5,
              ),
              const InputText(hint: 'الرقم'),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                  onPressed: widget.onPressed, child: const Icon(Icons.add)),
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
