import 'package:organize_me/database/db.dart';
import 'package:sqflite/sqflite.dart';

class Task {
  final int id;
  final String title;
  final String tag;
  final String content;
  final String creationDate;
  final String startDate;
  final String endDate;
  final String status;

  const Task({
    required this.id,
    required this.title,
    required this.tag,
    required this.content,
    required this.creationDate,
    required this.endDate,
    required this.startDate,
    required this.status,
  });

  static Task fromMap(Map taskMap) {
    return Task(
      id: taskMap['id'],
      content: taskMap['content'],
      creationDate: taskMap['creation_date'],
      endDate: taskMap['end_date'],
      startDate: taskMap['start_map'],
      status: taskMap['status'],
      tag: taskMap['tag'],
      title: taskMap['title'],
    );
  }

  static Future<Map> addTask(
    String title,
    String content,
    String? tag,
    String startDate,
    String endDate,
  ) async {
    Database? mydb = await DatabaseHelper.db;
    String now = DateTime.now().toString();
    int noteId = await mydb!.rawInsert(
      """
        INSERT OR IGNORE INTO tasks(title,
                                    content,
                                    createion_date,
                                    tag,
                                    start_date,
                                    end_date)

                                    VALUES (?, ?, ?, ?, ?, ?);
      """,
      [
        title,
        content,
        now,
        tag,
        startDate,
        endDate,
      ],
    );
    return (await geOnetTask(noteId));
  }

  static Future<Map> editTask(
    int taskId, {
    String newContent = '',
    String newTitle = '',
    String newStartDate = '',
    String newEndDate = '',
    String newTag = '',
  }) async {
    Database? mydb = await DatabaseHelper.db;
    String lastModified = DateTime.now().toString();
    String editContent =
        newContent.isNotEmpty ? "content = '$newContent'," : "";
    String editTitle = newTitle.isNotEmpty ? "title = '$newTitle'," : "";
    String editStartDate =
        newStartDate.isNotEmpty ? "start_date = '$newStartDate'," : "";
    String editEndDate =
        newEndDate.isNotEmpty ? "end_date = '$newEndDate'," : "";
    String editTag = newTag.isNotEmpty ? "tag = '$newTag'," : "";
    await mydb!.rawUpdate(
      """
        UPDATE tasks SET $editContent
                         $editTitle
                         $editStartDate
                         $editEndDate
                         $editTag
                         last_modified = ? WHERE id = ?;
      """,
      [
        lastModified,
        taskId,
      ],
    );
    return geOnetTask(taskId);
  }

  static deleteTask(int taskId) async {
    Database? mydb = await DatabaseHelper.db;
    await mydb!.rawInsert(
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
