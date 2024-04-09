import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/notes_section/models/note.dart';

import 'note_item.dart';

class NoteListView extends StatefulWidget {
  final List<Note> notes;
  const NoteListView({super.key, required this.notes});

  @override
  State<NoteListView> createState() => _NoteListViewState();
}

class _NoteListViewState extends State<NoteListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: widget.notes.length,
        itemBuilder: (context, index) {
          return NoteItem(note: widget.notes[index]);
        },
      ),
    );
  }
}
