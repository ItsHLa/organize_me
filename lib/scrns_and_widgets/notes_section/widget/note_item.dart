import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/bloc/notes_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/database/db.dart';
import 'package:organize_me/scrns_and_widgets/notes_section/models/Note.dart';

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
            // deleting on long press !!!!!!!!!!!!
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NotePage(
                  note: note,
                ),
              ),
            ),
            title: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        note.title,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    const Spacer()
                  ],
                ),
                const Divider()
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                note.content,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
          ),
          Row(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 10),
                child: Text(
                  note.date,
                  style: const TextStyle(fontSize: 12),
                ),
              )
            ],
          )
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
      content: const Text(
        'هل انت متأكد من حذف هذه المهمة ؟',
        textAlign: TextAlign.center,
        style: TextStyle(color: deepPurple),
      ),
      actionsAlignment: MainAxisAlignment.center,
      contentPadding: const EdgeInsets.all(30),
      contentTextStyle: const TextStyle(fontSize: 15),
      actions: [
        ElevatedButton(
          onPressed: () async {
            Note note =
                Note.fromMap(await DatabaseHelper.geOnetNote(widget.noteId));
            await DatabaseHelper.deleteNote(widget.noteId);
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
