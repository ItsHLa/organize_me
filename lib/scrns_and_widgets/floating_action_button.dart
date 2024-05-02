import 'package:flutter/material.dart';

import '../constants.dart';

class MyFab extends StatelessWidget {
  const MyFab({
    super.key,
    required this.icon,
    this.onPressed,
  });

  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: softPurple,
      shape: const StadiumBorder(),
      onPressed: onPressed,
      child: Icon(
        icon,
        color: black,
      ),
    );
  }
}
