import 'package:organize_me/database/db.dart';
import 'package:sqflite/sqflite.dart';

class Med {
  static const tableName = "meds";
  final int id;
  final String name;
  final String shotTime;
  final int interval;
  const Med({
    required this.id,
    required this.interval,
    required this.name,
    required this.shotTime,
  });
  static Med fromMap(Map medMap) {
    return Med(
      id: medMap['id'],
      interval: medMap['interval'],
      name: medMap['name'],
      shotTime: medMap['shot_time'],
    );
  }

  static Future<Map> addMed(String name, String shotTime, int interval) async {
    Database? mydb = await DatabaseHelper.db;
    int medId = await mydb!.insert(
        tableName, {"name": name, "shot_time": shotTime, "interval": interval});
    return await getOneMed(medId);
  }

  static Future<Map> editMed(
    int medId, {
    String newName = '',
    int newInterval = 0,
    String newShotTime = '',
  }) async {
    Database? mydb = await DatabaseHelper.db;
    Map<String, Object> values = {
      "last_modified": DateTime.now().toString(),
    };
    if (newName.isNotEmpty) values['name'] = newName;
    if (newInterval != 0) values['interval'] = newInterval;
    if (newShotTime.isNotEmpty) values['shot_time'] = newShotTime;
    await mydb!.update(tableName, values, where: "id = ?", whereArgs: [medId]);
    return await getOneMed(medId);
  }

  static Future deleteMed(int medId) async {
    Database? mydb = await DatabaseHelper.db;
    await mydb!.delete(tableName, where: "id = ?", whereArgs: [medId]);
  }

  static Future<Map> getOneMed(int medId) async {
    Database? mydb = await DatabaseHelper.db;
    List<Map> med =
        await mydb!.query(tableName, where: "id = ?", whereArgs: [medId]);

    return med[0];
  }

  static Future<List<Med>> getAllMeds() async {
    Database? mydb = await DatabaseHelper.db;
    List<Map> medsMap = await mydb!.rawQuery(tableName);
    List<Med> meds = [];
    for (Map med in medsMap) {
      meds.add(fromMap(med));
    }
    return meds;
  }
}
