import 'package:flutter/material.dart';

class IconButtonCustom extends StatefulWidget {
  const IconButtonCustom({super.key, required this.logic, required this.icon});

  final IconData icon;
  final void Function()? logic;

  @override
  State<IconButtonCustom> createState() => _IconButtonCustomState();
}

class _IconButtonCustomState extends State<IconButtonCustom> {
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: widget.logic, icon: Icon(widget.icon));
  }
}
