import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/notes_section/models/Note.dart';

import '../bloc/notes_bloc.dart';
import 'note_item.dart';

class NoteListView extends StatefulWidget {
  const NoteListView({super.key});

  @override
  State<NoteListView> createState() => _NoteListViewState();
}

class _NoteListViewState extends State<NoteListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          List<Note> notes = BlocProvider.of<NotesBloc>(context).notes;
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return NoteItem(note: notes[index]);
            },
          );
        },
      ),
    );
  }
}
