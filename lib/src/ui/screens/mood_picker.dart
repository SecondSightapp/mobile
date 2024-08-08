import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import '../themes/source_colors.dart';
import '../components/navbar.dart';
import '../components/star.dart';

const stars = [
  Star(mood: "sad"),
  Star(mood: "happy"),
  Star(mood: "angry"),
  Star(mood: "cool"),
  Star(mood: "neutral"),
  Star(mood: "worried"),
  Star(mood: "chill"),
  Star(mood: "disgusted"),
  Star(mood: "calm"),
  Star(mood: "delighted"),
  Star(mood: "naughty"),
  Star(mood: "annoyed"),
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
      body: Column(
        children: [
          const MoodCounter(),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 12.0, bottom: 12.0),
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