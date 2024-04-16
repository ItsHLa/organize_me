import 'package:flutter/material.dart';

import 'models/task.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails(
      {super.key,
      this.onPressedEdit,
      this.onPressedDelete,
      required this.task});

  final void Function()? onPressedEdit;
  final void Function()? onPressedDelete;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: onPressedEdit, child: const Text('تعديل')),
          TextButton(onPressed: onPressedDelete, child: const Text('حذف')),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.black54)),
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: const Column(
                    children: [
                      Text(
                        'TaskName',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text('7 : 00 - 8 : 00', style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
                const FontStyleDetailsPage(title: 'الحالة', text: 'مكتمل'),
                const SizedBox(
                  height: 5,
                ),
                const FontStyleDetailsPage(title: 'التاريخ', text: '27/3/2024'),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: ListView(
                    children: const [
                      Text(
                        'njavdvsvshgushugbhsubhusfhbusfbusfusfuvbubusbnjavdvsvshgushugbhsubhusfhbusfbusfusnjavdvsvshgushugbhsubhusfhbusfbusfusnjavdvsvshgushugbhsubhusfhbusfbusfusfuvbubusbhusfhvufnjavdvsvshgushugbhsubhusfhbusfbusfusfuvbubusbhusfhvuffuvbubusbhusfhvuffuvbubusbhusfhvufhusfhvuf',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}

class FontStyleDetailsPage extends StatelessWidget {
  const FontStyleDetailsPage({
    super.key,
    required this.title,
    required this.text,
  });

  final String title;

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black54)),
          child: Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
