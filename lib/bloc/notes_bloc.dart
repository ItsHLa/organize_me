import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/notes_section/models/Note.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  List<Note> notes = [];
  NotesBloc() : super(const NotesInitial(notes: [])) {
    on<AddNoteEvent>(_addNote);
    on<DeleteNoteEvent>(_deleteNote);
    on<UpdateNoteEvent>(_updateNote);
  }
  void _addNote(AddNoteEvent event, Emitter<NotesState> emit) {
    notes.add(event.note);
    emit(NotesUpdated(notes: notes));
  }

  void _deleteNote(DeleteNoteEvent event, Emitter<NotesState> emit) {
    for (Note note in notes) {
      if (note.id == event.note.id) {
        notes.remove(note);
        break;
      }
    }
    emit(NotesUpdated(notes: notes));
  }

  void _updateNote(UpdateNoteEvent event, Emitter<NotesState> emit) {
    for (Note note in notes) {
      if (note.id == event.note.id) {
        int i = notes.indexOf(note);
        notes[i] = event.note;
        break;
      }
    }
    emit(NotesUpdated(notes: notes));
  }
}
