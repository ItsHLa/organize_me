import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.label});

  final IconData icon;
  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          padding: const EdgeInsets.all(8),
          backgroundColor: darkBlue),
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
