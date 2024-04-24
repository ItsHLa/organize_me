import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/notes_section/models/note.dart';

import '../../functionality.dart';
import '../../input_text.dart';
import '../bloc/notes_bloc.dart';

class Input extends StatefulWidget {
  const Input({
    super.key,
    required this.title,
    required this.content,
    required this.action,
    required this.icon,
    this.noteId,
  });

  final int? noteId;
  final String title;
  final String content;
  final String action;
  final IconData icon;

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  String newTitle = '';
  String newContent = '';
  AutovalidateMode validateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Form(
        key: formKey,
        autovalidateMode: validateMode,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
              InputText(
                hint: widget.title,
                save: (value) {
                  newTitle = value ?? '';
                },
                maxLength: 30,
              ),
              const SizedBox(height: 4),
              InputText(
                hint: widget.content,
                lines: 4,
                save: (value) {
                  newContent = value ?? '';
                },
              ),
              const SizedBox(height: 5),
              ElevatedButton.icon(
                onPressed: () async {
                  validateMode = AutovalidateMode.always;
                  formKey.currentState!.save();
                  if (widget.action == 'اضافة الملاحظة') {
                    if (newTitle.isEmpty || newContent.isEmpty) {
                      validateField(formKey);
                      return;
                    }
                    Map noteMap = await Note.addNote(
                      newTitle,
                      newContent,
                    );
                    if (context.mounted) {
                      BlocProvider.of<NotesBloc>(context).add(
                        AddNoteEvent(
                          note: Note.fromMap(noteMap),
                        ),
                      );
                    }
                  } else if (widget.action == 'تعديل الملاحظة') {
                    if (newTitle.isEmpty && newContent.isEmpty) {
                      validateField(formKey);
                      return;
                    }
                    Map noteMap = await Note.editNote(
                      widget.noteId!,
                      newTitle: newTitle,
                      newContent: newContent,
                    );
                    if (context.mounted) {
                      BlocProvider.of<NotesBloc>(context).add(
                        UpdateNoteEvent(
                          note: Note.fromMap(noteMap),
                        ),
                      );
                    }
                  }
                },
                icon: Icon(widget.icon),
                label: Text(widget.action),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
