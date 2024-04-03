import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/bloc/notes_bloc.dart';
import 'package:organize_me/database/db.dart';
import 'package:organize_me/scrns_and_widgets/notes_section/models/Note.dart';
import 'note_item.dart';

class NoteListView extends StatefulWidget {
  const NoteListView({super.key});

  @override
  State<NoteListView> createState() => _NoteListViewState();
}

class _NoteListViewState extends State<NoteListView> {
  late List<Note> _notes;
  void _getAllNotes() async {
    List<Map> notes = await DatabaseHelper.getAllNotes();
    for (Map note in notes) {
      _notes.add(Note.fromMap(note));
    }
  }

  @override
  void initState() {
    _getAllNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          if (state is NotesUpdated) {
            _notes = state.notes;
          }
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: _notes.length,
            itemBuilder: (context, index) {
              return NoteItem(note: _notes[index]);
            },
          );
        },
      ),
    );
  }
}
