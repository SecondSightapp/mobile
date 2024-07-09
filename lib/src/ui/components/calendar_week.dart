import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../themes/source_colors.dart';

final months = [
  'January', 'February', 'March', 'April', 'May', 'June',
  'July', 'August', 'September', 'October', 'November', 'December'
];

final weekdays = [
  'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
];

class DayBox extends StatelessWidget {
  final String day;
  final Color moodColor;
  final bool isCurrent;

  const DayBox({super.key, required this.day, required this.moodColor, this.isCurrent = false});

  Widget getBox() {
    return Icon(
      Icons.star_rounded,
      color: isCurrent ? Colors.white : Colors.transparent,
      size: 30.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          day,
          style: GoogleFonts.lexend(
            textStyle: const TextStyle(
              color: themePurple,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: moodColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: getBox(),
        ),
      ],
    );
  }
}

class CalendarWeek extends StatelessWidget {
  const CalendarWeek({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2.0, right: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {

                },
                child: const Icon(
                  Icons.keyboard_arrow_left,
                  color: themePurple,
                ),
              ),
              Text(
                months[DateTime.now().month - 1],
                style: GoogleFonts.lexend(
                  textStyle: const TextStyle(
                    color: themePurple,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  
                },
                child: const Icon(
                  Icons.keyboard_arrow_right,
                  color: themePurple,
                ),
              ),
            ],
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
        const Padding(padding: EdgeInsets.only(bottom: 8.0)),
      ],
    );
  }
}