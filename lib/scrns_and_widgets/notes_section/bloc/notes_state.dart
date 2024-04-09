part of 'notes_bloc.dart';

@immutable
sealed class NotesState {
  final List<Note> notes;
  const NotesState({required this.notes});
}

class NoteUpdated extends NotesState {
  final Note note;
  const NoteUpdated({
    required super.notes,
    required this.note,
  });
}

class NoteAdded extends NotesState {
  const NoteAdded({required super.notes});
}

class NoteDeleted extends NotesState {
  const NoteDeleted({required super.notes});
}

class NotesLoading extends NotesState {
  const NotesLoading({required super.notes});
}

class NotesLoadingCompleted extends NotesState {
  const NotesLoadingCompleted({required super.notes});
}
