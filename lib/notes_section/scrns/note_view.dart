import 'package:flutter/material.dart';
import '../widget/note_list_view.dart';
import 'note_task.dart';

class NoteView extends StatelessWidget {
  const NoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return const AddTaskScrn();
              });
        },
        shape: const StadiumBorder(),
        child: const Icon(Icons.add_task),
      ),
      body: const Column(
        children: [
          Expanded(child: TaskListView()),
        ],
      ),
    );
  }
}
