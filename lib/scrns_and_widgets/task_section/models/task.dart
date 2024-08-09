import 'package:organize_me/database/db.dart';
import 'package:sqflite/sqflite.dart';

class Task {
  static const String tableName = "tasks";
  final int id;
  final String title;
  final String content;
  final String creationDate;
  final String startDate;
  final String startTime;
  final int preAlarm;
  final String status;

  const Task({
    required this.id,
    required this.title,
    required this.content,
    required this.creationDate,
    required this.preAlarm,
    required this.startTime,
    required this.status,
    required this.startDate,
  });

  static Task fromMap(Map taskMap) {
    return Task(
        id: taskMap['id'],
        content: taskMap['content'],
        creationDate: taskMap['creation_date'],
        preAlarm: taskMap['pre_alarm'],
        startTime: taskMap['start_time'],
        status: taskMap['status'],
        title: taskMap['title'],
        startDate: taskMap['start_date']);
  }

  static Future<Map> addTask({
    required String title,
    required String content,
    required String startTime,
    required int preAlarm,
    required String startDate,
    required String status,
  }) async {
    Database? mydb = await DatabaseHelper.db;
    String now = DateTime.now().toString();
    int taskId = await mydb!.insert(
      tableName,
      {
        "title": title,
        "content": content,
        "creation_date": now,
        "start_time": startTime,
        "pre_alarm": preAlarm,
        "status": status,
        "start_date": startDate,
      },
    );
    return (await geOneTask(taskId));
  }

  static Future<Map> editTask(
    int taskId, {
    required String newContent,
    required String newTitle,
    required String newStartTime,
    required int newPreAlarm,
    required String newStartDate,
  }) async {
    Database? mydb = await DatabaseHelper.db;
    Map<String, Object> values = {
      "last_modified": DateTime.now().toString(),
    };
    if (newContent.isNotEmpty) values['content'] = newContent;
    if (newTitle.isNotEmpty) values['title'] = newTitle;
    if (newStartTime.isNotEmpty) values['start_time'] = newStartTime;
    if (newPreAlarm != 0) values['pre_alarm'] = newPreAlarm;
    if (newStartDate.isNotEmpty) values['start_date'] = newStartDate;
    await mydb!.update(
      tableName,
      values,
      where: "id = ?",
      whereArgs: [taskId],
    );
    return await geOneTask(taskId);
  }

  static Future<Map> editTaskStatus(
    int taskId, {
    required String newStatus,
  }) async {
    Database? mydb = await DatabaseHelper.db;
    Map<String, Object> values = {
      "last_modified": DateTime.now().toString(),
    };
    assert(newStatus.isNotEmpty, "newStatus is empty");
    values['status'] = newStatus;

    await mydb!.update(
      tableName,
      values,
      where: "id = ?",
      whereArgs: [taskId],
    );
    return await geOneTask(taskId);
  }

  static Future deleteTask(int taskId) async {
    Database? mydb = await DatabaseHelper.db;
    await mydb!.delete(
      tableName,
      where: "id = ?",
      whereArgs: [
        taskId,
      ],
    );
  }

  static Future<Map> geOneTask(int taskId) async {
    Database? mydb = await DatabaseHelper.db;
    List<Map> task = await mydb!.query(
      tableName,
      where: "id = ?",
      whereArgs: [
        taskId,
      ],
    );

    return task[0];
  }

  static Future<List<Task>> getTasksByDate(String date) async {
    Database? mydb = await DatabaseHelper.db;
    List<Map> tasksMap = await mydb!.query(
      tableName,
      where: "start_date = ?",
      whereArgs: [date],
    );

    List<Task> tasks = [];
    for (Map task in tasksMap) {
      tasks.add(fromMap(task));
    }
    return tasks;
  }
}
