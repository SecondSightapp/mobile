import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secondsight/src/ui/components/journal_popup.dart';
import '../themes/source_colors.dart';

class JournalCard extends StatelessWidget {
  final String title;
  final String content;

  const JournalCard({super.key, required this.title, required this.content});

  void _showEntry(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const JournalPopup();
      }
    );
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
          onTap: () {
            _showEntry(context);
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: GoogleFonts.lexend(
                      color: themePurple,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    content.length > 20 ? '${content.substring(0, 20)}...' : content,
                    style: GoogleFonts.lexend(
                      color: themePurple,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
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