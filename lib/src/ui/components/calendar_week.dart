import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../themes/source_colors.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import '../../data/mood_state.dart';
import '../../data/moods.dart';
import '../../constants.dart';
import '../../data/mood_star.dart';

final months = [
  'January', 'February', 'March', 'April', 'May', 'June',
  'July', 'August', 'September', 'October', 'November', 'December'
];

final weekdays = [
  'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
];

class CalendarWeek extends StatefulWidget {
  const CalendarWeek({super.key});

  @override
  State<CalendarWeek> createState() => _CalendarWeekState();
}

class _CalendarWeekState extends State<CalendarWeek> {
  final List<MoodStar> _moodLog = [];

  Future<void> getMoods() async {
    try {
      final moods = await MoodService.getStars(); 
      setState(() {
        _moodLog.clear();
        _moodLog.addAll(moods); 
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load moods: $e')),
      );
    }
  }

  String getMoodForDate(DateTime date) {
    DateTime dateUtc = DateTime.utc(date.year, date.month, date.day);
    MoodStar? mood = _moodLog.lastWhere((mood) => DateTime.utc(mood.date.year, mood.date.month, mood.date.day) == dateUtc, orElse: () => MoodStar(date: dateUtc, mood: "neutral"));
    return mood.mood.toString();
  }

  @override
  void initState() {
    super.initState();
    getMoods();
  }

  Widget customDayBuilder(
    bool isSelectable,
    int index,
    bool isSelectedDay,
    bool isToday,
    bool isPrevMonthDay,
    TextStyle textStyle,
    bool isNextMonthDay,
    bool isThisMonthDay,
    DateTime day
  ) {
    DateTime date = DateTime.utc(day.year, day.month, day.day);

    Text dayText = Text(
      day.day.toString(),
      style: GoogleFonts.lexend(
        textStyle: const TextStyle(
          color: themePurple,
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
      ),
    );

    Widget display = isToday ? Stack(
      children: [
        const Center(
          child: Icon(
            Icons.star_rounded,
            color: Colors.white,
            size: 40,
          ),
        ),
        Center(child: dayText),
      ],
    ) : dayText;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: moods[getMoodForDate(date)] ?? const Color.fromRGBO(233, 233, 233, 1),
      ),
      child: Center(
        child: display
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.14,
        child: CalendarCarousel(
          customDayBuilder: customDayBuilder,
          weekFormat: true,
          iconColor: themePurple,
          headerMargin: EdgeInsets.zero,
          headerTextStyle: GoogleFonts.lexend(
            textStyle: const TextStyle(
              color: themePurple,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          weekDayFormat: WeekdayFormat.narrow,
          weekDayMargin: EdgeInsets.zero,
          weekdayTextStyle: GoogleFonts.lexend(
            textStyle: const TextStyle(
              color: themePurple,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          todayButtonColor: Colors.transparent,
          selectedDayButtonColor: Colors.transparent,
          pageScrollPhysics: const ScrollPhysics(),
          onCalendarChanged: (date) {
            customDayBuilder(
              true,
              1,
              true,
              true,
              false,
              GoogleFonts.lexend(
                textStyle: const TextStyle(
                  color: themePurple,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              false,
              true,
              date
            );
          },
        ),
      ),
    );
  }
}