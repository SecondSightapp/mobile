import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import '../themes/source_colors.dart';
import '../components/navbar.dart';
import '../components/star.dart';

const stars = [
  Star(color: Color.fromRGBO(181, 200, 229, 1)),
  Star(color: Color.fromRGBO(245, 229, 198, 1)),
  Star(color: Color.fromRGBO(216, 160, 156, 1)),
  Star(color: Color.fromRGBO(181, 200, 229, 1)),
  Star(color: Color.fromRGBO(245, 229, 198, 1)),
  Star(color: Color.fromRGBO(216, 160, 156, 1)),
  Star(color: Color.fromRGBO(181, 200, 229, 1)),
  Star(color: Color.fromRGBO(245, 229, 198, 1)),
  Star(color: Color.fromRGBO(216, 160, 156, 1)),
  Star(color: Color.fromRGBO(181, 200, 229, 1)),
  Star(color: Color.fromRGBO(245, 229, 198, 1)),
  Star(color: Color.fromRGBO(216, 160, 156, 1)),
  Star(color: Color.fromRGBO(181, 200, 229, 1)),
  Star(color: Color.fromRGBO(245, 229, 198, 1)),
  Star(color: Color.fromRGBO(216, 160, 156, 1)),
  Star(color: Color.fromRGBO(181, 200, 229, 1)),
  Star(color: Color.fromRGBO(245, 229, 198, 1)),
  Star(color: Color.fromRGBO(216, 160, 156, 1)),
  Star(color: Color.fromRGBO(181, 200, 229, 1)),
  Star(color: Color.fromRGBO(245, 229, 198, 1)),
  Star(color: Color.fromRGBO(216, 160, 156, 1)),
  Star(color: Color.fromRGBO(181, 200, 229, 1)),
  Star(color: Color.fromRGBO(245, 229, 198, 1)),
  Star(color: Color.fromRGBO(216, 160, 156, 1)),
  Star(color: Color.fromRGBO(181, 200, 229, 1)),
  Star(color: Color.fromRGBO(245, 229, 198, 1)),
  Star(color: Color.fromRGBO(216, 160, 156, 1)),
  Star(color: Color.fromRGBO(181, 200, 229, 1)),
  Star(color: Color.fromRGBO(245, 229, 198, 1)),
  Star(color: Color.fromRGBO(216, 160, 156, 1)),
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
      // navbar
      bottomNavigationBar: NavBar(
        selectedIndex: 0,
      ),
    );
  }
}

class MoodPickerBody extends StatelessWidget {
  const MoodPickerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 30.0,
      mainAxisSpacing: 30.0,
      padding: const EdgeInsets.all(25.0),
      children: stars,
    );
  }
}