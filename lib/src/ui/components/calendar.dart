import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DayBox extends StatelessWidget {
  final String day;
  final Color moodColor;
  final bool isCurrent;

  const DayBox({super.key, required this.day, required this.moodColor, this.isCurrent = false});

  Widget getBox() {
    if (isCurrent) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
          ),
          const Icon(Icons.star, color: Colors.white),
        ],
      );
    } else {
      return Container(
        color: moodColor,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          day,
          style: GoogleFonts.lexend(
            textStyle: const TextStyle(
              color: Color.fromRGBO(209, 196, 197, 1),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          color: moodColor,
          child: getBox(),
        ),
      ],
    );
  }
}

class Calendar extends StatelessWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.keyboard_arrow_left),
            Text('July'),
            Icon(Icons.keyboard_arrow_right),
          ],
        ),
        Row(
          children: [
            DayBox(
              day: 'S',
              moodColor: Color.fromRGBO(216, 160, 156, 1),
            ),
            DayBox(
              day: 'M',
              moodColor: Color.fromRGBO(189, 172, 198, 1),
            ),
            DayBox(
              day: 'T',
              moodColor: Color.fromRGBO(204, 226, 200, 1),
            ),
            DayBox(
              day: 'W',
              moodColor: Color.fromRGBO(181, 200, 229, 1),
              isCurrent: true,
            ),
            DayBox(
              day: 'T',
              moodColor: Color.fromRGBO(233, 233, 233, 1),
            ),
            DayBox(
              day: 'F',
              moodColor: Color.fromRGBO(233, 233, 233, 1),
            ),
            DayBox(
              day: 'S',
              moodColor: Color.fromRGBO(233, 233, 233, 1),
            ),
          ],
        ),
      ],
    );
  }
}