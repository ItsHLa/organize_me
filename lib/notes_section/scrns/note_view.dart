import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/notes_section/widget/search_widget.dart';
import '../widget/note_list_view.dart';
import 'note_task.dart';

class NoteView extends StatefulWidget {
  const NoteView({super.key});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {

   Widget myWidget = const Spacer();
   Icon myIcon = const Icon(Icons.search_outlined);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          showModalBottomSheet(

              isScrollControlled: true,
              context: context,
              builder: (context) {
                return const AddTaskScrn();
              });
        },
        shape: const StadiumBorder(),
        child: const Icon(Icons.add_task),
      ),
      body:  Column(
        children: [
          Container(
            margin: const EdgeInsets.all(8),
              height: 50,
              child: const MySearchWidget(),),
          const Expanded(child: NoteListView()),
        ],
      ),
    );
  }
}
