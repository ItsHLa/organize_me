part of 'notes_bloc.dart';

@immutable
sealed class NotesState {
  final List<Note> notes;
  const NotesState({required this.notes});
}

final class NotesInitial extends NotesState {
  const NotesInitial({required super.notes});
}

class NotesUpdated extends NotesState {
  const NotesUpdated({required super.notes});
}
