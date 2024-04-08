class Task {
  final int id;
  final String title;
  final String tag;
  final String content;
  final String creationDate;
  final String startDate;
  final String endDate;
  final String reminder;
  final String status;

  const Task({
    required this.id,
    required this.title,
    required this.tag,
    required this.content,
    required this.creationDate,
    required this.endDate,
    required this.startDate,
    required this.reminder,
    required this.status,
  });

  static Task fromMap(Map taskMap) {
    return Task(
      id: taskMap['id'],
      content: taskMap['content'],
      creationDate: taskMap['creation_date'],
      endDate: taskMap['end_date'],
      startDate: taskMap['start_map'],
      reminder: taskMap['reminder'],
      status: taskMap['status'],
      tag: taskMap['tag'],
      title: taskMap['title'],
    );
  }
}
