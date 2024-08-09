import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/journal_popup.dart';
import '../themes/source_colors.dart';
import '../../data/moods.dart';
import '../../data/journal_entry.dart';
import '../../data/entries.dart';
import '../../constants.dart';

class CalendarEntry extends StatelessWidget {
  final String title;
  final String content;
  final DateTime date;
  final JournalEntry entry;

  CalendarEntry({super.key, required this.entry}) : title = entry.title, content = entry.content, date = entry.createdAt;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 224,
      height: 182,
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: () async {
            final result = await showDialog<Map<String, String>>(
              context: context,
              builder: (BuildContext context) {
                return JournalPopup(title: title, content: content);
              }
            );
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.lexend(
                        color: themePurple,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: moods[moodState.moodLog[DateTime.utc(date.year, date.month, date.day)]] ?? const Color.fromRGBO(233, 233, 233, 1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    content.length > 100 ? '${content.substring(0, 180)}...' : content,
                    style: GoogleFonts.lexend(
                      color: themePurple,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}