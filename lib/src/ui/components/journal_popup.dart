import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:secondsight/src/ui/screens/journal_screen.dart";
import "../themes/source_colors.dart";

class JournalPopup extends StatelessWidget {
  final String title, content;

  const JournalPopup({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.7,
      child: AlertDialog(
        backgroundColor: Colors.white,
        icon: const Icon(Icons.book, color: themePurple),
        scrollable: true,
        title: Text(
          title,
          style: GoogleFonts.lexend(
            textStyle: const TextStyle(
              color: themePurple,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        content: Text(
          content,
          style: GoogleFonts.lexend(
            textStyle: const TextStyle(
              color: themePurple,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const JournalScreen()),
              );
            },
            icon: const Icon(Icons.edit),
            label: const Text('edit'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close),
            label: const Text('close'),
          ),
        ]
      ),
    );
  }
}