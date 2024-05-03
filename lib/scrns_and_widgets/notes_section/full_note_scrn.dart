import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/notes_section/models/note.dart';

import 'bloc/notes_bloc.dart';
import 'widget/icon_button.dart';
import 'widget/input.dart';

class NotePage extends StatelessWidget {
  final Note note;

  const NotePage({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        Note currNote = note;
        // if (state is NoteUpdated || state is NoteDeleted) {
        if (state is NoteUpdated) {
          SchedulerBinding.instance.addPostFrameCallback(
            (_) {
              Navigator.of(context).pop();
            },
          );
          // if (state is NoteUpdated) {
          currNote = state.note;
          // }
          // BlocProvider.of<NotesBloc>(context)
          //     .emit(NotesLoadingCompleted(notes: state.notes));
        }
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      currNote.title,
                      style: const TextStyle(fontSize: 15),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        IconButtonCustom(
                          icon: Icons.edit,
                          logic: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => Input(
                                noteId: currNote.id,
                                title: 'عنوان الملاحظة',
                                content: 'الوصف',
                                action: 'تعديل الملاحظة',
                                icon: Icons.edit,
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
                const Divider(),
                SingleChildScrollView(
                  child: Text(
                    currNote.content,
                  ),
                ),
                Row(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8,
                        right: 8,
                      ),
                      child: Text(
                        currNote.date,
                        style: const TextStyle(fontSize: 12),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
