import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/bloc/notes_bloc.dart';

import 'add_note.dart';
import 'widget/note_list_view.dart';

class NoteView extends StatefulWidget {
  const NoteView({super.key});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        if (state is NoteAdded) {
          Navigator.of(context).pop();
        }
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.endContained,
          floatingActionButton: FloatingActionButton.small(
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return const AddNoteScrn();
                },
              );
            },
            shape: const StadiumBorder(),
            child: const Icon(Icons.add_task),
          ),
          body: const Column(
            children: [
              Expanded(child: NoteListView()),
            ],
          ),
        );
      },
    );
  }
}
