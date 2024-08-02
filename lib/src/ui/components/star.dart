import 'package:flutter/material.dart';
import '../../data/moods.dart';
import '../../constants.dart';

class Star extends StatelessWidget {
  final String mood;

  const Star({super.key, required this.mood});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DateTime now = DateTime.now();
        moodState.addMoodData(DateTime.utc(now.year, now.month, now.day), mood);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.25,
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: ShapeDecoration(
          color: moods[mood],
          shape: const StarBorder(
            innerRadiusRatio: 0.5,
            pointRounding: 0.5,
          ),
        ),
      ),
    );
  }
}