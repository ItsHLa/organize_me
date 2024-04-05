import 'package:organize_me/scrns_and_widgets/notes_section/models/Note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _db;

  static Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  static intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'data.db');
    // await databaseFactory.deleteDatabase(path);
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }

  static _onUpgrade(Database db, int oldversion, int newversion) {}

  static _onCreate(Database db, int version) async {
    await db.execute(
      '''
          CREATE TABLE IF NOT EXISTS notes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            content TEXT NOT NULL,
            date TEXT,
            last_modified TEXT DEFAULT NULL
          );
      ''',
    );
  }

  static Future<Map> addNote(String title, String content) async {
    Database? mydb = await db;
    String now = DateTime.now().toString();
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
      {String newContent = '', String newTitle = ''}) async {
    assert(newContent.isNotEmpty || newTitle.isNotEmpty);
    Database? mydb = await db;
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
    Database? mydb = await db;
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
    Database? mydb = await db;
    List<Map> note = await mydb!.rawQuery(
      """
        SELECT * FROM notes WHERE id = ?
      """,
      [
        noteId,
      ],
    );

    return note[0];
  }

  static Future<List<Note>> getAllNotes() async {
    Database? mydb = await db;
    List<Map> notesMap = await mydb!.rawQuery(
      """
        SELECT * FROM notes
      """,
    );
    List<Note> notes = [];
    for (Map note in notesMap) {
      notes.add(Note.fromMap(note));
    }
    return notes;
  }
}
