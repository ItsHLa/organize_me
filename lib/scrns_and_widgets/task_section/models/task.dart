import 'package:organize_me/database/db.dart';
import 'package:sqflite/sqflite.dart';

class Task {
  final int id;
  final String title;
  final String content;
  final String creationDate;
  final String startDate;
  final String startTime;
  final String endTime;
  final String status;

  const Task({
    required this.id,
    required this.title,
    required this.content,
    required this.creationDate,
    required this.endTime,
    required this.startTime,
    required this.status,
    required this.startDate,
  });

  static Task fromMap(Map taskMap) {
    return Task(
        id: taskMap['id'],
        content: taskMap['content'],
        creationDate: taskMap['creation_date'],
        endTime: taskMap['end_time'],
        startTime: taskMap['start_time'],
        status: taskMap['status'],
        title: taskMap['title'],
        startDate: taskMap['start_date']);
  }

  static Future<Map> addTask(
    String title,
    String content,
    String startTime,
    String endTime,
    String startDate,
  ) async {
    Database? mydb = await DatabaseHelper.db;
    String now = DateTime.now().toString();
    int noteId = await mydb!.rawInsert(
      """
        INSERT OR IGNORE INTO tasks(title,
                                    content,
                                    creation_date,
                                    start_time,
                                    end_time,
                                    start_date)

                                    VALUES (?, ?, ?, ?, ?, ?);
      """,
      [
        title,
        content,
        now,
        startTime,
        endTime,
        startDate,
      ],
    );
    return (await geOnetTask(noteId));
  }

  static Future<Map> editTask(
    int taskId, {
    String newContent = '',
    String newTitle = '',
    String newStartTime = '',
    String newEndTime = '',
    String newStartDate = '',
  }) async {
    Database? mydb = await DatabaseHelper.db;
    String lastModified = DateTime.now().toString();
    String editContent =
        newContent.isNotEmpty ? "content = '$newContent'," : "";
    String editTitle = newTitle.isNotEmpty ? "title = '$newTitle'," : "";
    String editStartTime =
        newStartTime.isNotEmpty ? "start_time = '$newStartTime'," : "";
    String editEndTime =
        newEndTime.isNotEmpty ? "end_time = '$newEndTime'," : "";
    String editStartDate =
        newStartDate.isNotEmpty ? "end_time = '$newStartDate'," : "";
    await mydb!.rawUpdate(
      """
        UPDATE tasks SET $editContent
                         $editTitle
                         $editStartTime
                         $editEndTime
                         $editStartDate
                         last_modified = ? WHERE id = ?;
      """,
      [
        lastModified,
        taskId,
      ],
    );
    return geOnetTask(taskId);
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

  static Future<Map> geOnetTask(int taskId) async {
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

  static Future<List<Task>> getAllTasks() async {
    Database? mydb = await DatabaseHelper.db;
    List<Map> tasksMap = await mydb!.rawQuery(
      """
        SELECT * FROM tasks
      """,
    );
    List<Task> tasks = [];
    for (Map task in tasksMap) {
      tasks.add(Task.fromMap(task));
    }
    return tasks;
  }
}
