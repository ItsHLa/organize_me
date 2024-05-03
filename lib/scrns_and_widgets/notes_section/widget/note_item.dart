import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/notes_section/models/note.dart';
import 'package:organize_me/scrns_and_widgets/notes_section/widget/icon_button.dart';

import '../bloc/notes_bloc.dart';
import '../full_note_scrn.dart';

class NoteItem extends StatelessWidget {
  final Note note;

  const NoteItem({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => NotePage(
                  note: note,
                ),
              );
            },
            trailing: IconButtonCustom(
              logic: () {
                showDialog(
                  context: context,
                  builder: (context) => AlterDialogCustom(
                    noteId: note.id,
                  ),
                );
              },
              icon: Icons.cancel_outlined,
            ),
            subtitle: Text(
              note.date,
            ),
            title: Text(
              note.title,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(note.content, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}

class AlterDialogCustom extends StatefulWidget {
  final int noteId;

  const AlterDialogCustom({super.key, required this.noteId});

  @override
  State<AlterDialogCustom> createState() => _AlterDialogCustomState();
}

class _AlterDialogCustomState extends State<AlterDialogCustom> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        'هل انت متأكد من حذف هذه المهمة ؟',
        textAlign: TextAlign.center,
        style: TextStyle(color: appColorTheme),
      ),
      actionsAlignment: MainAxisAlignment.center,
      contentPadding: const EdgeInsets.all(30),
      contentTextStyle: const TextStyle(fontSize: 15),
      actions: [
        ElevatedButton(
          onPressed: () async {
            Note note = Note.fromMap(await Note.geOnetNote(widget.noteId));
            await Note.deleteNote(widget.noteId);
            if (context.mounted) {
              BlocProvider.of<NotesBloc>(context).add(
                DeleteNoteEvent(note: note),
              );
              Navigator.of(context).pop();
            }
          },
          child: const Text('نعم'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('لا'),
        ),
      ],
    );
  }
}
