import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secondsight/src/ui/components/journal_popup.dart';
import '../themes/source_colors.dart';
import '../../data/journal_entry.dart';

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
          onTap: () async {
            final result = await showDialog<Map<String, String>>(
              context: context,
              builder: (BuildContext context) {
                return JournalPopup(title: widget.title, content: widget.content);
              }
            );

            if (result != null) {
              setState(() {
                _title = result['title'] ?? '';
                _content = result['content'] ?? '';
              });
            }
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.title.length > 40 ? '${widget.title.substring(0, 40)}...' : widget.title,
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
                    widget.content.length > 40 ? '${widget.content.substring(0, 40)}...' : widget.content,
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