class JournalEntry {
  String title;
  String content;
  DateTime createdAt;
  DateTime updatedAt;

  JournalEntry(this.title, this.content) : createdAt = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day), updatedAt = DateTime.now();
}