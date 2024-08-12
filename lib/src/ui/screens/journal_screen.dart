import 'package:flutter/material.dart';
import 'package:secondsight/src/ui/themes/source_colors.dart';
import 'entry_screen.dart'; 
import '../components/journal_popup.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/entries.dart';
import '../../data/journal_entry.dart';
import '../../constants.dart';
import '../../data/moods.dart';
import '../../data/mood_state.dart';
import '../../data/mood_star.dart';


class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final List<Map<String, dynamic>> _entries = [];

  void _addEntry(Map<String, dynamic> entry) {
    setState(() {
      _entries.add(entry);
      entries.add(JournalEntry(entry['title'], entry['description']));
    });
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
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: Column(
        children: [
          const HeaderSection(),
          SortButton(onCreateEntry: _addEntry),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: entries.length,
              itemBuilder: (context, index) {
                JournalEntry e = entries[index];
                String dateString = e.createdAt.toIso8601String().split('T').first;
                return EntryCard(entry: {
                  'title': e.title,
                  'description': e.content,
                  'color': moods[getMoodForDate(e.createdAt)],
                  'date': '${dateString.substring(5, 7)}/${dateString.substring(8, 10)}/${dateString.substring(0, 4)}',
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Column(
        children: [
          Image.asset(
            'assets/images/starHeader.png',
            width: 60,
            height: 57,
          ),
          const SizedBox(height: 10),
          Text(
            'time to reflect',
            style: GoogleFonts.lexend(
                textStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: themePurple,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SortButton extends StatelessWidget {
  final void Function(Map<String, dynamic>) onCreateEntry;

  const SortButton({super.key, required this.onCreateEntry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                ),
                builder: (context) {
                  return const SortOptions();
                },
              );
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              backgroundColor: Colors.white,
              shadowColor: Colors.transparent,
              side: const BorderSide(color: Color(0xFFE0E0E0), width: 1.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Sort by',
                  style: GoogleFonts.lexend(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: themePurple,
                    ),
                  ),
                ),
                const SizedBox(width: 5.0),
                const Icon(Icons.keyboard_arrow_down_rounded, color: themePurple),
              ],
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () async {
              final newEntry = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateEntryScreen(),
                ),
              );

              if (newEntry != null) {
                onCreateEntry(newEntry);
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              backgroundColor: Colors.white,
              shadowColor: Colors.transparent,
              side: const BorderSide(color: Color(0xFFE0E0E0), width: 1.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Create',
                  style: GoogleFonts.lexend(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: themePurple,
                    ),
                  ),
                ),
                const SizedBox(width: 5.0),
                const Icon(Icons.add),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SortOptions extends StatelessWidget {
  const SortOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.sort_by_alpha, color: themePurple),
            title: const Text('Sort by Mood type'),
            onTap: () {
              // TODO: handle sort by mood
            },
          ),
          ListTile(
            leading: const Icon(Icons.bookmark, color: themePurple),
            title: const Text('Sort by Bookmarks'),
            onTap: () {
              // TODO: handle sort by bookmarks
            },
          ),
        ],
      ),
    );
  }
}

class EntryCard extends StatefulWidget {
  final Map<String, dynamic> entry;

  const EntryCard({super.key, required this.entry});

  @override
  _EntryCardState createState() => _EntryCardState();
}

class _EntryCardState extends State<EntryCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () async {
          final updatedEntry = await showDialog<Map<String, String>>(
            context: context,
            builder: (BuildContext context) {
              return JournalPopup(
                initialTitle: widget.entry['title'],
                initialContent: widget.entry['description'] ?? 'No description',
              );
            }
          );

          if (updatedEntry != null) {
            setState(() {
              widget.entry['title'] = updatedEntry['title'] ?? widget.entry['title'];
              widget.entry['description'] = updatedEntry['content'] ?? widget.entry['description'];
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: widget.entry['color'],
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        widget.entry['title'],
                        style: GoogleFonts.lexend(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: themePurple,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.bookmark_border, color: themePurple),
                        onPressed: () {
                          // TODO: handle bookmark press
                        },
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        widget.entry['date'],
                        style: GoogleFonts.lexend(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: themePurple,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
