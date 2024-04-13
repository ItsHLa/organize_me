import 'package:flutter/material.dart';

class IconForm extends StatelessWidget {
  const IconForm({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white54, borderRadius: BorderRadius.circular(20)),
      child: child,
    );
  }
}
