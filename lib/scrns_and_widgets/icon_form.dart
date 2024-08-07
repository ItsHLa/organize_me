import 'package:flutter/material.dart';

class IconForm extends StatelessWidget {
  const IconForm({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const StadiumBorder(side: BorderSide(color: Colors.white54)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}
