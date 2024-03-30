import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widget/note_list_view.dart';
import '../widget/search_widget.dart';
import 'add_note.dart';

class NoteView extends StatefulWidget {
  const NoteView({super.key});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {

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
                return const AddNoteScrn();
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
