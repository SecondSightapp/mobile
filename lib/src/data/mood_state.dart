import "package:flutter/material.dart";

class MoodState extends ChangeNotifier {
  final Map<DateTime, String> _moodLog = {
    DateTime.utc(2024, 7, 21): "angry",
    DateTime.utc(2024, 7, 22): "worried",
    DateTime.utc(2024, 7, 23): "disgusted",
    DateTime.utc(2024, 7, 24): "sad",
    DateTime.utc(2024, 7, 25): "happy",
  };

  Map<DateTime, String> get moodLog => _moodLog;

  void addMoodData(DateTime date, String mood) {
    _moodLog[date] = mood;
    notifyListeners();
  }
}