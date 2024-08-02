import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secondsight/src/ui/components/journal_card.dart';
import 'package:secondsight/src/ui/screens/mood_picker.dart';
import '../components/navbar.dart';
import '../themes/source_colors.dart';
import '../components/star.dart';
import '../components/calendar_week.dart';

// the list of journal cards
var journalCards = [
  // keep the first one, use to create new cards
  const JournalCard(
    title: 'view library',
    content: 'create new...',
  ),
  const JournalCard(
    title: 'Entry 1',
    content: 'excerpt...',
  ),
  const JournalCard(
    title: 'Entry 2',
    content: 'excerpt...',
  ),
  const JournalCard(
    title: 'Entry 3',
    content: 'excerpt...',
  ),
];

Map<String, String> journalData = {};

// home page layout
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar with title and buttons for menu and settings
      appBar: AppBar(
        title: Center(
          child: Text(
            "second sight",
            style: GoogleFonts.lexend(
              textStyle: const TextStyle(
                color: Color.fromRGBO(209, 196, 197, 1),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: themePurple,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {
            // open the menu
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              // open settings
            }
          ),
        ],
      ),
      body: const HomePageBody(),
      // navbar
      bottomNavigationBar: NavBar(
        selectedIndex: 0,
      ),
    );
  }
}

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Star(color: Color.fromRGBO(181, 200, 229, 1)),
              Star(color: Color.fromRGBO(245, 229, 198, 1)),
              Star(color: Color.fromRGBO(216, 160, 156, 1)),
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
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 12.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(171, 179, 209, 0.7),
                    offset: Offset(5, 5),
                  ),
                ],
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
              children: journalCards,
            ),
          ),
        ],
      ),
    );
  }
}