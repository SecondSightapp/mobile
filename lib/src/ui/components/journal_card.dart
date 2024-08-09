import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secondsight/src/ui/components/journal_popup.dart';
import '../themes/source_colors.dart';

class JournalCard extends StatefulWidget {
  final String title;
  final String content;

  const JournalCard({super.key, required this.title, required this.content});

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
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: () async {
            final result = await showDialog<Map<String, String>>(
              context: context,
              builder: (BuildContext context) {
                return JournalPopup(
                  initialTitle: _title,
                  initialContent: _content,
                );
              },
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
                    _title,
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
                    _content.length > 20 ? '${_content.substring(0, 20)}...' : _content,
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
