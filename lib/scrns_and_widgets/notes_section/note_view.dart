import 'package:flutter/material.dart';
<<<<<<< HEAD:lib/scrns_and_widgets/notes_section/scrns/note_view.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/bloc/notes_bloc.dart';
import '../widget/note_list_view.dart';
=======

>>>>>>> 328cb563f6df3866d8bc62b839b1d78f56ce7e7f:lib/scrns_and_widgets/notes_section/note_view.dart
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
    return BlocProvider(
      create: (context) => NotesBloc(),
      child: Scaffold(
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
        body: const Column(
          children: [
            Expanded(child: NoteListView()),
          ],
        ),
      ),
    );
  }
}
