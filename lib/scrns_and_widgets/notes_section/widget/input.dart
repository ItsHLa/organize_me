import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/bloc/notes_bloc.dart';
import 'package:organize_me/database/db.dart';
import 'package:organize_me/scrns_and_widgets/notes_section/models/Note.dart';
import '../../input_text.dart';

class Input extends StatefulWidget {
  const Input(
      {super.key,
      required this.title,
      required this.content,
      required this.action,
      required this.icon,
      this.noteId});

  final int? noteId;
  final String title;
  final String content;
  final String action;
  final IconData icon;

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  late String newTitle;
  late String newContent;
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
                lines: 5,
                save: (value) => newContent = value ?? '',
              ),
              const SizedBox(height: 5),
              ElevatedButton.icon(
                onPressed: () async {
                  if (InputText.validateFiled(formKey)) {
                    formKey.currentState!.save();
                  } else {
                    validateMode = AutovalidateMode.always;
                  }
                  if (widget.action == 'اضافة الملاحظة') {
                    Map noteMap = await DatabaseHelper.addNote(
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
                    Map noteMap = await DatabaseHelper.editNote(
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
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
