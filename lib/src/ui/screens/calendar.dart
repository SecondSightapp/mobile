import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../themes/source_colors.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import '../../data/mood_state.dart';
import '../../data/moods.dart';
import '../../constants.dart';
import '../../data/entries.dart';
import '../../data/journal_entry.dart';
import '../components/calendar_entry.dart';
import '../../data/mood_star.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<JournalEntry> _selectedDayEntries = entries.where((entry) {
    DateTime entryDate = DateTime.utc(entry.createdAt.year, entry.createdAt.month, entry.createdAt.day);
    DateTime now = DateTime.now();
    DateTime today = DateTime.utc(now.year, now.month, now.day);
    return entryDate == today;
  }).toList();

  final List<MoodStar> _moodLog = [];

  Future<void> getMoods() async {
    try {
      final moods = await MoodService.getStars(); 
      setState(() {
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
    MoodStar? mood = _moodLog.firstWhere((mood) => DateTime.utc(mood.date.year, mood.date.month, mood.date.day) == dateUtc, orElse: () => MoodStar(date: dateUtc, mood: "neutral"));
    return mood.mood.toString();
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
          fontSize: 14,
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
    return Container(
      color: const Color.fromRGBO(247, 247, 247, 1),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: CalendarCarousel(
                customDayBuilder: customDayBuilder,
                iconColor: themePurple,
                weekFormat: false,
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
                onDayPressed: (p0, p1) {
                  setState(() {
                    _selectedDayEntries = entries.where((entry) {
                      DateTime entryDate = DateTime.utc(entry.createdAt.year, entry.createdAt.month, entry.createdAt.day);
                      DateTime p0Date = DateTime.utc(p0.year, p0.month, p0.day);
                      return entryDate == p0Date;
                    }).toList();
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: _selectedDayEntries.isEmpty
            ? Center(
              child: Text(
                'no entries for this day',
                style: GoogleFonts.lexend(
                  textStyle: const TextStyle(
                    color: themePurple,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ) : ListView(
              padding: const EdgeInsets.all(8.0),
              scrollDirection: Axis.vertical,
              children: _selectedDayEntries.map((e) => CalendarEntry(entry: e)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}