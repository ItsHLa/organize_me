import 'package:organize_me/database/db.dart';
import 'package:sqflite/sqflite.dart';

class Note {
  final int id;
  final String title;
  final String content;
  final String date;
  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
  });

  static Note fromMap(Map noteMap) {
    return Note(
      id: noteMap['id'],
      title: noteMap['title'],
      content: noteMap['content'],
      date: noteMap['date'],
    );
  }

  static Future<Map> addNote(String title, String content) async {
    Database? mydb = await DatabaseHelper.db;
    String now = DateTime.now().toString().substring(0, 16);
    int noteId = await mydb!.rawInsert(
      """
        INSERT OR IGNORE INTO notes(title, content, date) VALUES (?, ?, ?);
      """,
      [
        title,
        content,
        now,
      ],
    );
    return (await geOnetNote(noteId));
  }

  static Future<Map> editNote(int noteId,
      {required String newContent, required String newTitle}) async {
    Database? mydb = await DatabaseHelper.db;
    String lastModified = DateTime.now().toString();
    String editContent =
        newContent.isNotEmpty ? "content = '$newContent'," : "";
    String editTitle = newTitle.isNotEmpty ? "title = '$newTitle'," : "";
    await mydb!.rawUpdate(
      """
        UPDATE notes SET $editContent $editTitle last_modified = ? WHERE id = ?;
      """,
      [
        lastModified,
        noteId,
      ],
    );
    return geOnetNote(noteId);
  }

  static deleteNote(int noteId) async {
    Database? mydb = await DatabaseHelper.db;
    await mydb!.rawInsert(
      """
        DELETE FROM notes WHERE id = ?;
      """,
      [
        noteId,
      ],
    );
  }

  static Future<Map> geOnetNote(int noteId) async {
    Database? mydb = await DatabaseHelper.db;
    List<Map> note = await mydb!.rawQuery(
      """
        SELECT * FROM notes WHERE id = ?;
      """,
      [
        noteId,
      ],
    );

    return note[0];
  }

  static Future<List<Note>> getAllNotes() async {
    Database? mydb = await DatabaseHelper.db;
    List<Map> notesMap = await mydb!.rawQuery(
      """
        SELECT * FROM notes;
      """,
    );
    List<Note> notes = [];
    for (Map note in notesMap) {
      notes.add(Note.fromMap(note));
    }
    return notes;
  }
}
