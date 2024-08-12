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
  final List<MoodStar> _moodLog = [];
  final List<JournalEntry> _entries = [];
  List<JournalEntry> _selectedDayEntries = [];

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

  Future<void> getEntries() async {
    try {
      final entries = await NoteService.getEntries(); 
      setState(() {
        _entries.addAll(entries); 
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load entries: $e')),
      );
    }
  }

  String getMoodForDate(DateTime date) {
    DateTime dateUtc = DateTime.utc(date.year, date.month, date.day);
    MoodStar? mood = _moodLog.lastWhere((mood) => DateTime.utc(mood.date.year, mood.date.month, mood.date.day) == dateUtc, orElse: () => MoodStar(date: dateUtc, mood: "neutral"));
    return mood.mood.toString();
  }

  List<JournalEntry> getEntriesForDate(DateTime date) {
    DateTime dateUtc = DateTime.utc(date.year, date.month, date.day);
    return _entries.where((entry) => DateTime.utc(entry.createdAt.year, entry.createdAt.month, entry.createdAt.day) == dateUtc).toList();
  }

  @override
  void initState() {
    super.initState();
    getMoods();
    getEntries();
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
                    _selectedDayEntries = getEntriesForDate(p0);
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