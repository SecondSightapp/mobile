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

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  

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
          fontSize: 15,
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
        color: moods[moodState.moodLog[date]] ?? const Color.fromRGBO(233, 233, 233, 1),
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
                    
                  });
                },
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}