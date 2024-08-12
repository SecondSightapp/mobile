import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secondsight/src/ui/components/journal_card.dart';
import 'package:secondsight/src/ui/components/new_journal_card.dart';
import 'package:secondsight/src/ui/screens/mood_picker.dart';
import '../themes/source_colors.dart';
import '../components/star.dart';
import '../components/calendar_week.dart';
import '../../data/entries.dart';
import '../../data/journal_entry.dart';
import '../../data/mood_star.dart';
import '../../data/mood_state.dart';

// home page layout
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<JournalEntry> _entries = [];
  final List<MoodStar> _moodLog = [];

  @override
  void initState() {
    super.initState();
    _fetchNotes();
    getMoods();
  }
  
  Future<void> _fetchNotes() async {
  try {
    final notes = await NoteService.getEntries(); 
    setState(() {
      _entries.addAll(notes); 
    });
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to load notes: $e')),
    );
  }
  }

  void _addEntry(Map<String, dynamic> entry) {
    setState(() {
      _entries.add(JournalEntry(
        id: entry['id'], 
        title: entry['title'], 
        content: entry['description'], 
        createdAt: entry['createdAt'], 
        updatedAt: entry['updatedAt']
      ));
    });
  }

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
    MoodStar? mood = _moodLog.lastWhere((mood) => DateTime.utc(mood.date.year, mood.date.month, mood.date.day) == dateUtc, orElse: () => MoodStar(date: dateUtc, mood: "neutral"));
    return mood.mood.toString();
  }


  List<Widget> topThreeEntries() {
    List<Widget> topThree = _entries.map((e) => JournalCard(entry: e)).toList();

    // finds the three most recently updated entries and displays them the order of most recently updated
    topThree.sort((a, b) {
      return (b as JournalCard).entry.updatedAt.compareTo((a as JournalCard).entry.updatedAt);
    });

    // return the first three entries, and if there are less than three entries, return the whole list
    return topThree.length > 3 ? topThree.sublist(0, 3) : topThree;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(247, 247, 247, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // "how are you feeling today?" prompt
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.125,
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.025),
              child: Center(
                child: Text(
                  'how are you feeling today?',
                  style: GoogleFonts.lexend(
                    textStyle: const TextStyle(
                      color: themePurple,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // stars that the user can click on to choose a mood
          // display top 3 moods
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Star(mood: "SAD", isPoppable: false),
              Star(mood: "HAPPY", isPoppable: false),
              Star(mood: "ANGRY", isPoppable: false),
            ],
          ),
          // "view more" button to view all moods
          Padding(
            padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.07),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MoodPicker()),
                  );
                },
                child: Text(
                  'view more...',
                  style: GoogleFonts.lexend(
                    textStyle: const TextStyle(
                      color: themePurple,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // calendar component
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 12.0),
            child: Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: Color(0xFFE0E0E0)),
              ),
              child: const CalendarWeek(),
            ),
          ),
          // "start journaling" prompt
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
            child: Center(
              child: Text(
                'start journaling',
                style: GoogleFonts.lexend(
                  textStyle: const TextStyle(
                    color: themePurple,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          // create a new entry and view most recent entries
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              scrollDirection: Axis.horizontal,
              children: [
                const NewJournalCard(),
                ... topThreeEntries(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}