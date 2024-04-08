import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: ExpansionTile(
          shape: const StadiumBorder(),
          title: const Text('Task Name'),
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text(
                'Description Description Description Description',
              ),
            ),
            const Row(
              children: [
                Spacer(),
                IconButton(
                  onPressed: null,
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: null,
                  icon: Icon(Icons.delete),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}
