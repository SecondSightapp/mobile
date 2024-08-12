import 'package:flutter/material.dart';
import 'package:secondsight/src/ui/screens/loading_screen.dart';
import '../../data/moods.dart';
import '../../constants.dart';
import '../../data/mood_state.dart';
import '../screens/journal_screen.dart';

final Map<String, String> moodStars = {
  "ANGRY": "assets/images/stars/angry_star.png",
  "ANNOYED": "assets/images/stars/annoyed_star.png",
  "CALM": "assets/images/stars/calm_star.png",
  "CHILL": "assets/images/stars/chill_star.png",
  "COOL": "assets/images/stars/cool_star.png",
  "DELIGHTED": "assets/images/stars/delighted_star.png",
  "DISGUSTED": "assets/images/stars/disgusted_star.png",
  "HAPPY": "assets/images/stars/happy_star.png",
  "NAUGHTY": "assets/images/stars/naughty_star.png",
  "NEUTRAL": "assets/images/stars/neutral_star.png",
  "SAD": "assets/images/stars/sad_star.png",
  "WORRIED": "assets/images/stars/worried_star.png",
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
        MoodService.addStar(mood.toUpperCase());
        if (isPoppable) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoadingScreen()));
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