class Note {
  final int id;
  final String title;
  final String content;
  final String date;
  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
  });

  static Note fromMap(Map noteMap) {
    return Note(
      id: noteMap['id'],
      title: noteMap['title'],
      content: noteMap['content'],
      date: noteMap['date'],
    );
  }
}
