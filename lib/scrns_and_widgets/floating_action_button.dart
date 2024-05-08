import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../constants.dart';

class MyFab extends StatelessWidget {
  const MyFab({
    super.key,
    this.onPressed,
    required this.children,
  });

  final List<SpeedDialChild> children;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.menu_outlined,
      iconTheme: const IconThemeData(color: Colors.white60),
      children: children,
      backgroundColor: appColorTheme,
      shape: const CircleBorder(),
    );
  }
}
/*
* FloatingActionButton(
      backgroundColor: softPurple,
      shape: const StadiumBorder(),
      onPressed: onPressed,
      child: Icon(
        icon,
        color: black,
      ),
    )
*
* */