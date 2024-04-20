import 'package:flutter/material.dart';

import 'my_button.dart';

class InputDataPage extends StatelessWidget {
  const InputDataPage(
      {super.key,
      required this.child,
      required this.onPressed,
      required this.icon,
      required this.label});

  final Widget child;
  final void Function()? onPressed;
  final IconData icon;

  final String label;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          child,
          const SizedBox(
            height: 10,
          ),
          MyButton(onPressed: onPressed, icon: icon, label: label),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
