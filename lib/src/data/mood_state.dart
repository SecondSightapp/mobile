import "package:flutter/material.dart";

class MoodState extends ChangeNotifier {
  final Map<DateTime, String> _moodLog = {
    DateTime.utc(2024, 7, 21): "angry",
    DateTime.utc(2024, 7, 22): "worried",
    DateTime.utc(2024, 7, 23): "disgusted",
    DateTime.utc(2024, 7, 24): "sad",
    DateTime.utc(2024, 7, 25): "happy",
    DateTime.utc(2024, 7, 26): "angry",
    DateTime.utc(2024, 7, 27): "disgusted",
    DateTime.utc(2024, 7, 28): "cool",
    DateTime.utc(2024, 7, 29): "neutral",
    DateTime.utc(2024, 7, 30): "worried",
    DateTime.utc(2024, 7, 31): "chill",
    DateTime.utc(2024, 8, 1): "disgusted",
    DateTime.utc(2024, 8, 2): "calm",
    DateTime.utc(2024, 8, 3): "delighted",
    DateTime.utc(2024, 8, 4): "angry",
    DateTime.utc(2024, 8, 5): "worried",
    DateTime.utc(2024, 8, 6): "disgusted",
    DateTime.utc(2024, 8, 7): "calm",
    DateTime.utc(2024, 8, 8): "calm",
    DateTime.utc(2024, 8, 9): "calm",
  };

  Map<DateTime, String> get moodLog => _moodLog;

  void addMoodData(DateTime date, String mood) {
    _moodLog[date] = mood;
    notifyListeners();
  }
}