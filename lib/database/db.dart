import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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

  static Future intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'data.db');
    Database mydb = await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onUpgrade: _onUpgrade,
    );
    return mydb;
  }

  static _onUpgrade(Database db, int oldversion, int newversion) async {
  }

  static _onCreate(Database db, int version) async {
    await db.execute(
      '''
          CREATE TABLE IF NOT EXISTS tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            content TEXT NOT NULL,
            creation_date TEXT,
            start_date TEXT, -- YYYY-MM-DD
            start_time TEXT, -- HH:MM
            pre_alarm INTEGER,
            status TEXT DEFAULT 'متوقف',
            last_modified TEXT DEFAULT NULL
          );
      ''',
    );
    await db.execute(
      '''
          CREATE TABLE IF NOT EXISTS doctors_contacts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            phone TEXT NOT NULL,
            name TEXT NOT NULL,
            specialist TEXT NOT NULL,
            clinic_number TEXT NOT NULL
          );
      ''',
    );
    await db.execute(
      '''
          CREATE TABLE IF NOT EXISTS electric_bills (
            id INTEGER PRIMARY KEY AUTOINCREMENT,

            payment_amount DOUBLE NOT NULL DEFAULT 0,
            commission_amount DOUBLE NOT NULL DEFAULT 0,
            date TEXT, -- YYYY-MM-DD
            time TEXT, -- HH:MM
            provider TEXT,
            operation_number TEXT UNIQUE,

            gov TEXT,

            billing_number TEXT,
            invoice_number TEXT,
            subscription_number TEXT
          );
      ''',
    );
    await db.execute(
      '''
          CREATE TABLE IF NOT EXISTS temp_electric_bills (
            id INTEGER PRIMARY KEY AUTOINCREMENT,

            payment_amount DOUBLE NOT NULL DEFAULT 0,
            commission_amount DOUBLE NOT NULL DEFAULT 0,
            date TEXT, -- YYYY-MM-DD
            time TEXT, -- HH:MM
            provider TEXT,
            operation_number TEXT UNIQUE,

            gov TEXT,

            billing_number TEXT,
            invoice_number TEXT,
            subscription_number TEXT
          );
      ''',
    );
    await db.execute(
      '''
          CREATE TABLE IF NOT EXISTS water_bills (
            id INTEGER PRIMARY KEY AUTOINCREMENT,

            payment_amount DOUBLE NOT NULL DEFAULT 0,
            commission_amount DOUBLE NOT NULL DEFAULT 0,
            date TEXT, -- YYYY-MM-DD
            time TEXT, -- HH:MM
            provider TEXT,
            operation_number TEXT UNIQUE,

            gov TEXT,

            receipt_number TEXT,
            barcode_number TEXT,
            counter_number TEXT

          );
      ''',
    );
    await db.execute(
      '''
          CREATE TABLE IF NOT EXISTS temp_water_bills (
            id INTEGER PRIMARY KEY AUTOINCREMENT,

            payment_amount DOUBLE NOT NULL DEFAULT 0,
            commission_amount DOUBLE NOT NULL DEFAULT 0,
            date TEXT, -- YYYY-MM-DD
            time TEXT, -- HH:MM
            provider TEXT,
            operation_number TEXT UNIQUE,

            gov TEXT,

            receipt_number TEXT,
            barcode_number TEXT,
            counter_number TEXT

          );
      ''',
    );
    await db.execute(
      '''
          CREATE TABLE IF NOT EXISTS telecom_bills (
            id INTEGER PRIMARY KEY AUTOINCREMENT,

            payment_amount DOUBLE NOT NULL DEFAULT 0,
            commission_amount DOUBLE NOT NULL DEFAULT 0,
            date TEXT, -- YYYY-MM-DD
            time TEXT, -- HH:MM
            provider TEXT,
            operation_number TEXT UNIQUE,

            invoice_number TEXT,
            phone_number_email TEXT
          );
      ''',
    );
    await db.execute(
      '''
          CREATE TABLE IF NOT EXISTS temp_telecom_bills (
            id INTEGER PRIMARY KEY AUTOINCREMENT,

            payment_amount DOUBLE NOT NULL DEFAULT 0,
            commission_amount DOUBLE NOT NULL DEFAULT 0,
            date TEXT, -- YYYY-MM-DD
            time TEXT, -- HH:MM
            provider TEXT,
            operation_number TEXT UNIQUE,

            invoice_number TEXT,
            phone_number_email TEXT
          );
      ''',
    );
    await db.execute(
      '''
          CREATE TABLE IF NOT EXISTS meds (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            shot_time TEXT,
            interval INTEGER,
            last_modified TEXT DEFAULT NULL
          );
      ''',
    );
  }
}
