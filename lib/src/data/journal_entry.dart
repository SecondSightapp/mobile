class JournalEntry {
  String title;
  String content;
  DateTime createdAt;
  DateTime updatedAt;
  bool bookmarked;
  JournalEntry(this.title, this.content) : createdAt = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day), updatedAt = DateTime.now(), bookmarked = false;
}