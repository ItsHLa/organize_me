import 'package:organize_me/database/db.dart';
import 'package:sqflite/sqflite.dart';

class Task {
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
  }) async {
    Database? mydb = await DatabaseHelper.db;
    String now = DateTime.now().toString();
    int taskId = await mydb!.rawInsert(
      """
        INSERT OR IGNORE INTO tasks(title,
                                    content,
                                    creation_date,
                                    start_time,
                                    pre_alarm,
                                    start_date)

                                    VALUES (?, ?, ?, ?, ?, ?);
      """,
      [
        title,
        content,
        now,
        startTime,
        preAlarm,
        startDate,
      ],
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
    String lastModified = DateTime.now().toString();
    String editContent =
        newContent.isNotEmpty ? "content = '$newContent'," : "";
    String editTitle = newTitle.isNotEmpty ? "title = '$newTitle'," : "";
    String editStartTime =
        newStartTime.isNotEmpty ? "start_time = '$newStartTime'," : "";
    String editPreAlarm = newPreAlarm != 0 ? "pre_alarm = $newPreAlarm," : "";
    String editStartDate =
        newStartDate.isNotEmpty ? "start_date = '$newStartDate'," : "";
    await mydb!.rawUpdate(
      """
        UPDATE tasks SET $editContent
                         $editTitle
                         $editStartTime
                         $editPreAlarm
                         $editStartDate
                         last_modified = ? WHERE id = ?;
      """,
      [
        lastModified,
        taskId,
      ],
    );
    return await geOneTask(taskId);
  }

  static Future deleteTask(int taskId) async {
    Database? mydb = await DatabaseHelper.db;
    await mydb!.rawDelete(
      """
        DELETE FROM tasks WHERE id = ?;
      """,
      [
        taskId,
      ],
    );
  }

  static Future<Map> geOneTask(int taskId) async {
    Database? mydb = await DatabaseHelper.db;
    List<Map> task = await mydb!.rawQuery(
      """
        SELECT * FROM tasks WHERE id = ?
      """,
      [
        taskId,
      ],
    );

    return task[0];
  }

  static Future<List<Task>> getTasksByDate(String date) async {
    Database? mydb = await DatabaseHelper.db;
    List<Map> tasksMap = await mydb!.rawQuery("""
        SELECT * FROM tasks WHERE start_date = ?;
      """, [
      date,
    ]);
    List<Task> tasks = [];
    for (Map task in tasksMap) {
      tasks.add(fromMap(task));
    }
    return tasks;
  }
}
