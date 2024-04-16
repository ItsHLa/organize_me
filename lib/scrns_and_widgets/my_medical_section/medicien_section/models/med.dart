import 'package:organize_me/database/db.dart';
import 'package:sqflite/sqflite.dart';

class Med {
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

  static Future<Med> addMed(String name, String shotTime, int interval) async {
    Database? mydb = await DatabaseHelper.db;
    int medId = await mydb!.rawInsert(
      """
        INSERT OR IGNORE INTO meds(name,
                                   shot_time,
                                   interval)
                                   VALUES (?, ?, ?);
      """,
      [
        name,
        shotTime,
        interval,
      ],
    );
    return fromMap(await getOneMed(medId));
  }

  static Future<Med> editMed(
    int medId, {
    String newName = '',
    int newInterval = 0,
    String newShotTime = '',
  }) async {
    Database? mydb = await DatabaseHelper.db;
    String lastModified = DateTime.now().toString();
    String editName = newName.isNotEmpty ? "name = '$newName'," : "";
    String editInterval = newInterval != 0 ? "interval = '$newInterval'," : "";
    String editShotTime =
        newShotTime.isNotEmpty ? "shot_time = '$newShotTime'," : "";
    await mydb!.rawUpdate(
      """
        UPDATE meds SET $editName
                         $editShotTime
                         $editInterval
                         last_modified = ? WHERE id = ?;
      """,
      [
        lastModified,
        medId,
      ],
    );
    return fromMap(await getOneMed(medId));
  }

  static Future deleteMed(int medId) async {
    Database? mydb = await DatabaseHelper.db;
    await mydb!.rawDelete(
      """
        DELETE FROM meds WHERE id = ?;
      """,
      [
        medId,
      ],
    );
  }

  static Future<Map> getOneMed(int medId) async {
    Database? mydb = await DatabaseHelper.db;
    List<Map> med = await mydb!.rawQuery(
      """
        SELECT * FROM meds WHERE id = ?
      """,
      [
        medId,
      ],
    );

    return med[0];
  }

  static Future<List<Med>> getAllMeds() async {
    Database? mydb = await DatabaseHelper.db;
    List<Map> medsMap = await mydb!.rawQuery(
      """
        SELECT * FROM meds
      """,
    );
    List<Med> meds = [];
    for (Map med in medsMap) {
      meds.add(fromMap(med));
    }
    return meds;
  }
}
