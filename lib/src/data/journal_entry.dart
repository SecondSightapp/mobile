class JournalEntry {
  String title;
  String content;
  DateTime createdAt;
  DateTime updatedAt;
  bool bookmarked;

  JournalEntry(this.title, this.content) : createdAt = DateTime.now(), updatedAt = DateTime.now(), bookmarked = false;
}