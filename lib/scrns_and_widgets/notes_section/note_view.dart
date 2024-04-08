import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/floating_action_button.dart';
import 'package:organize_me/scrns_and_widgets/notes_section/models/note.dart';

import '../app_bar.dart';
import 'add_note.dart';
import 'bloc/notes_bloc.dart';
import 'widget/note_list_view.dart';

class NoteView extends StatefulWidget {
  const NoteView({super.key});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  void _getAllNotes() async {
    BlocProvider.of<NotesBloc>(context).notes = await Note.getAllNotes();
  }

  @override
  void initState() {
    _getAllNotes();
    super.initState();
  }

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
          floatingActionButton: MyFab(
              icon: Icons.add,
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return const AddNoteScrn();
                  },
                );
              }),
          body: const Column(
            children: [
              MAppBar(),
              Expanded(child: NoteListView()),
            ],
          ),
        );
      },
    );
  }
}
