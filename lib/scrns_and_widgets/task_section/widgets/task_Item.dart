import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.value, this.onChange});

  final bool value;

  final void Function(bool?)? onChange;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        value: value,
        onChanged: onChange,
        shape: const StadiumBorder(),
        title: const Text('Task Name'),
        subtitle: Container(
          padding: const EdgeInsets.all(8),
          child: const Text(
            'Description Description Description Description',
          ),
        ));
  }
}
