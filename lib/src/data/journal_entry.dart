class JournalEntry {
  String title;
  String content;
  DateTime createdAt;
  DateTime updatedAt;

  JournalEntry(this.title, this.content) : createdAt = DateTime.now(), updatedAt = DateTime.now();
}