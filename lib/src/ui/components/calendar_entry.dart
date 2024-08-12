import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/journal_popup.dart';
import '../themes/source_colors.dart';
import '../../data/journal_entry.dart';
import '../../data/entries.dart';
import '../../constants.dart';
import '../../data/moods.dart';
import '../../data/mood_state.dart';
import '../../data/mood_star.dart';

class CalendarEntry extends StatefulWidget {
  final String title;
  final String content;
  final DateTime date;
  final JournalEntry entry;

  CalendarEntry({super.key, required this.entry}) : title = entry.title, content = entry.content, date = entry.createdAt;

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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Color(0xFFE0E0E0)),
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
                        color: moods[getMoodForDate(widget.date)] ?? const Color.fromRGBO(233, 233, 233, 1),
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
                    content.length > 125 ? '${content.substring(0, 125)}...' : content,
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
