import 'package:flutter/material.dart';

class MyRow extends StatelessWidget {
  const MyRow({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const Text('  : '),
        const SizedBox(
          width: 20,
        ),
        Text(value),
      ],
    );
  }
}
