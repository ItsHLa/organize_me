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

  static _onUpgrade(Database db, int oldversion, int newversion) async {
    // await DoctorsContacts.getAllContacts();
  }

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
    await db.execute(
      '''
          CREATE TABLE IF NOT EXISTS tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            content TEXT NOT NULL,
            tag TEXT,
            creation_date TEXT,
            start_time TEXT,
            end_time TEXT,
            status TEXT DEFAULT 'pending',
            last_modified TEXT DEFAULT NULL
          );
      ''',
    );
    await db.execute(
      '''
          CREATE TABLE IF NOT EXISTS doctors_contacts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            phone TEXT NOT NULL,
            name TEXT NOT NULL
          );
      ''',
    );
  }
}
