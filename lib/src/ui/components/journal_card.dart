import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secondsight/src/ui/components/journal_popup.dart';
import '../themes/source_colors.dart';
import '../../data/journal_entry.dart';
import '../screens/entry_display.dart';

class JournalCard extends StatefulWidget {
  final String title;
  final String content;
  final JournalEntry entry;

  JournalCard({super.key, required this.entry}) : title = entry.title, content = entry.content;

  @override
  State<JournalCard> createState() => _JournalCardState();
}

class _JournalCardState extends State<JournalCard> {
  String _title = '';
  String _content = '';

  @override
  void initState() {
    super.initState();
    _title = widget.title;
    _content = widget.content;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 224,
      height: 182,
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => EntryDisplay(title: _title, content: _content)));
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _title.length > 40 ? '${_title.substring(0, 40)}...' : _title,
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
                    _content.length > 40 ? '${_content.substring(0, 40)}...' : _content,
                    style: GoogleFonts.lexend(
                      color: themePurple,
                      fontSize: 20,
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
