import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'input_text.dart';
import 'my_button.dart';

class InputDataPage extends StatelessWidget {
  const InputDataPage(
      {super.key,
      //   required this.child,
      required this.onPressed,
      required this.icon,
      required this.labels,
      this.keyboardType,
      this.validator,
      required this.save,
      required this.labelButton,
      this.readOnly,
      this.onTap,
      required this.controllers});

  final void Function()? onPressed;
  final IconData icon;
  final String labelButton;
  final List labels;
  final List controllers;
  final List<TextInputType?>? keyboardType;
  final List<String? Function(String?)?>? validator;
  final List<void Function(String?)?> save;
  final List<bool?>? readOnly;
  final List<Function()?>? onTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: 8.0,
        left: 8,
        right: 8,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 76.0 * labels.length,
            child: ListView.builder(
              itemCount: labels.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: InputText(
                    readOnly: readOnly?[index],
                    onTap: onTap?[index],
                    controller: controllers[index],
                    labelText: labels[index],
                    keyboardType: keyboardType?[index],
                    validator: validator?[index],
                    save: save[index],
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          MyButton(onPressed: onPressed, icon: icon, label: labelButton),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
