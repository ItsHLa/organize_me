part of 'notes_bloc.dart';

@immutable
sealed class NotesEvent {}

class AddNoteEvent extends NotesEvent {
  final Note note;
  AddNoteEvent({required this.note});
}

class DeleteNoteEvent extends NotesEvent {
  final Note note;
  DeleteNoteEvent({required this.note});
}

class UpdateNoteEvent extends NotesEvent {
  final Note note;
  UpdateNoteEvent({required this.note});
}
