import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secondsight/src/ui/components/journal_card.dart';
import 'package:secondsight/src/ui/components/new_journal_card.dart';
import 'package:secondsight/src/ui/screens/mood_picker.dart';
import '../components/navbar.dart';
import '../themes/source_colors.dart';
import '../components/star.dart';
import '../components/calendar_week.dart';

// the list of journal cards
const journalCards = [
  // keep the first one, use to create new cards
  NewJournalCard(),
  JournalCard(
    title: 'Entry 1',
    content: 'excerpt...',
  ),
  JournalCard(
    title: 'Bee Movie',
    content: 'According to all known laws of aviation, there is no way a bee should be able to fly. Its wings are too small to get its fat little body off the ground. The bee, of course, flies anyway because bees don\'t care what humans think is impossible. Yellow, black. Yellow, black. Yellow, black. Yellow, black. Ooh, black and yellow! Let\'s shake it up a little. Barry! Breakfast is ready! Coming! Hang on a second. Hello? Barry? Adam? Can you believe this is happening? I can\'t. I\'ll pick you up. Looking sharp. Use the stairs, Your father paid good money for those. Sorry. I\'m excited. Here\'s the graduate. We\'re very proud of you, son. A perfect report card, all B\'s. Very proud. Ma! I got a thing going here. You got lint on your fuzz. Ow! That\'s me! Wave to us! We\'ll be in row 118,000. Bye! Barry, I told you, stop flying in the house! Hey, Adam. Hey, Barry. Is that fuzz gel? A little. Special day, graduation. Never thought I\'d make it. Three days grade school, three days high school. Those were awkward. Three days college. I\'m glad I took a day and hitchhiked around The Hive. You did come back different.',
  ),
  JournalCard(
    title: 'Entry 3',
    content: 'excerpt...',
  ),
];

Map<String, String> journalData = {};

// home page layout

class Homepage extends StatelessWidget {
  const Homepage({super.key});

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