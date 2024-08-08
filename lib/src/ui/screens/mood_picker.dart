import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import '../themes/source_colors.dart';
import '../components/navbar.dart';
import '../components/star.dart';

final stars = [
  Star(mood: "sad", isPoppable: true),
  Star(mood: "happy", isPoppable: true),
  Star(mood: "angry", isPoppable: true),
  Star(mood: "cool", isPoppable: true),
  Star(mood: "neutral", isPoppable: true),
  Star(mood: "worried", isPoppable: true),
  Star(mood: "chill", isPoppable: true),
  Star(mood: "disgusted", isPoppable: true),
  Star(mood: "calm", isPoppable: true),
  Star(mood: "delighted", isPoppable: true),
  Star(mood: "naughty", isPoppable: true),
  Star(mood: "annoyed", isPoppable: true),
];

class MoodPicker extends StatelessWidget {
  const MoodPicker({super.key});

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
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
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
      body: const MoodPickerBody(),
    );
  }
}

class MoodPickerBody extends StatefulWidget {
  const MoodPickerBody({super.key});

  @override
  State<MoodPickerBody> createState() => _MoodPickerBodyState();
}

class _MoodPickerBodyState extends State<MoodPickerBody> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(247, 247, 247, 1),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0, bottom: 25.0),
                controller: _scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 25.0,
                  mainAxisSpacing: 25.0,
                ),
                itemCount: stars.length,
                itemBuilder: (context, index) {
                  return stars[index];
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scrollToTop,
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}

class MoodCounter extends StatefulWidget {
  const MoodCounter({super.key});

  @override
  State<MoodCounter> createState() => _MoodCounterState();
}

class _MoodCounterState extends State<MoodCounter> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.04,
      child: Center(
        child: Text(
          "${stars.length}/50",
          style: GoogleFonts.lexend(
            textStyle: const TextStyle(
              color: themePurple,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}