import 'package:flutter/material.dart';

import 'icon_button.dart';
import 'input.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.pinkAccent,
              borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ExpansionTile(
                    shape: const BeveledRectangleBorder(),
                    title: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Task ',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    subtitle: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Spacer(),
                          Text('2024/03/16'),
                        ],
                      ),
                    ),
                    children: [
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(15),
                          child: const Text(
                              'contetacwjenvwbvuwbvurbvuibviubviuevbubvuvbudkmcivniwnvwnvwuvnuwvnwuvnuwvnuwdnvwvniwfunv'))
                    ],
                  ),
                ),
                IconButtonCustom(
                    icon: Icons.edit,
                    logic: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => const Input(
                                title: 'Task Name',
                                content: 'Description',
                                action: 'Edit task',
                                icon: Icons.edit,
                              ));
                    }),
                IconButtonCustom(
                    logic: () {
                      showDialog(
                          context: context,
                          builder: (context) => const AlterDialogCustom());
                    },
                    icon: Icons.delete_outline)
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AlterDialogCustom extends StatefulWidget {
  const AlterDialogCustom({super.key});
  @override
  State<AlterDialogCustom> createState() => _AlterDialogCustomState();
}

class _AlterDialogCustomState extends State<AlterDialogCustom> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text('Are you sure you want to delete this task?'),
      actionsAlignment: MainAxisAlignment.center,
      contentPadding: const EdgeInsets.all(30),
      contentTextStyle: const TextStyle(fontSize: 15),
      actions: [
        ElevatedButton(onPressed: () {}, child: const Text('Yes')),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('No')),
      ],
    );
  }
}
