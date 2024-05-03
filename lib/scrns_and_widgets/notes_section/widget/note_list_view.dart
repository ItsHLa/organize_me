import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/notes_section/bloc/notes_bloc.dart';
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
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            padding: EdgeInsets.zero,
            itemCount: widget.notes.length,
            itemBuilder: (context, index) {
              return NoteItem(note: widget.notes[index]);
            },
          ),
        );
      },
    );
  }
}
