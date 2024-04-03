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

  static addNote(String title, String content) async {
    Database? mydb = await db;
    String now = DateTime.now().toString();
    await mydb!.rawInsert(
      """
        INSERT OR IGNORE INTO notes(title, content, date) VALUES (?, ?, ?);
      """,
      [
        title,
        content,
        now,
      ],
    );
  }

  static editNote(int noteId,
      {String newContent = '', String newTitle = ''}) async {
    assert(newContent.isNotEmpty || newTitle.isNotEmpty);
    Database? mydb = await db;
    String lastModified = DateTime.now().toString();
    String editContent = newContent.isNotEmpty ? "content = $newContent," : "";
    String editTitle = newTitle.isNotEmpty ? "title = $newTitle," : "";
    await mydb!.rawInsert(
      """
        UPDATE notes SET $editContent $editTitle last_modified = ? WHERE id = ?;
      """,
      [
        lastModified,
        noteId,
      ],
    );
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

  static Future<List<Map>> geOnetNote(int noteId) async {
    Database? mydb = await db;
    List<Map> note = await mydb!.rawQuery(
      """
        SELECT * FROM notes WHERE id = ?
      """,
      [
        noteId,
      ],
    );
    return note;
  }

  static Future<List<Map>> getAllNotes() async {
    Database? mydb = await db;
    List<Map> notes = await mydb!.rawQuery(
      """
        SELECT * FROM notes
      """,
    );
    return notes;
  }
}
