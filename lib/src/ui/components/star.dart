import 'package:flutter/material.dart';
import '../../data/moods.dart';
import '../../constants.dart';
import '../../data/mood_state.dart';

final Map<String, String> moodStars = {
  "angry": "assets/images/stars/angry_star.png",
  "annoyed": "assets/images/stars/annoyed_star.png",
  "calm": "assets/images/stars/calm_star.png",
  "chill": "assets/images/stars/chill_star.png",
  "cool": "assets/images/stars/cool_star.png",
  "delighted": "assets/images/stars/delighted_star.png",
  "disgusted": "assets/images/stars/disgusted_star.png",
  "happy": "assets/images/stars/happy_star.png",
  "naughty": "assets/images/stars/naughty_star.png",
  "neutral": "assets/images/stars/neutral_star.png",
  "sad": "assets/images/stars/sad_star.png",
  "worried": "assets/images/stars/worried_star.png",
};

class Star extends StatelessWidget {
  final String mood;
  final String image;
  final bool isPoppable;

  Star({super.key, required this.mood, required this.isPoppable}) : image = moodStars[mood] ?? "assets/images/stars/neutral_star.png";

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        MoodService.addStar(mood);
        if (isPoppable) {
          Navigator.pop(context);
        }
      },
      child: Image.asset(
        image,
        width: MediaQuery.of(context).size.width * 0.25,
        height: MediaQuery.of(context).size.height * 0.1,
      ),
    );
  }
}