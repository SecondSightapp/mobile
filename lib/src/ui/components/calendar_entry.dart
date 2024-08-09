import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/journal_popup.dart';
import '../themes/source_colors.dart';
import '../../data/journal_entry.dart';
import '../../data/entries.dart';
import '../../constants.dart';

class CalendarEntry extends StatefulWidget {
  final JournalEntry entry;

  const CalendarEntry({super.key, required this.entry});

  @override
  _CalendarEntryState createState() => _CalendarEntryState();
}

class _CalendarEntryState extends State<CalendarEntry> {
  late String title;
  late String content;

  @override
  void initState() {
    super.initState();
    title = widget.entry.title;
    content = widget.entry.content;
  }

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
                return JournalPopup(
                  initialTitle: title,
                  initialContent: content,
                );
              },
            );

            if (result != null) {
              setState(() {
                title = result['title'] ?? title;
                content = result['content'] ?? content;
              });
            }
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
                    content.length > 100 ? '${content.substring(0, 100)}...' : content,
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
