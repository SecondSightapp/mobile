import 'package:secondsight/src/data/mood_state.dart';

class MoodStar {
  String mood;
  DateTime date;

  MoodStar({
    required this.mood,
    required this.date,
  });

  factory MoodStar.fromJson(Map<String, dynamic> json) {
    return MoodStar(
      mood: json['mood'],
      date: DateTime.parse(json['date']),
    );
  }
}