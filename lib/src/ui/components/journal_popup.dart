import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../themes/source_colors.dart';

class JournalPopup extends StatefulWidget {
  final String initialTitle;
  final String initialContent;

  const JournalPopup({super.key, required this.initialTitle, required this.initialContent});

  @override
  _JournalPopupState createState() => _JournalPopupState();
}

class _JournalPopupState extends State<JournalPopup> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _contentController = TextEditingController(text: widget.initialContent);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.7,
      child: AlertDialog(
        backgroundColor: Colors.white,
        icon: const Icon(Icons.book, color: themePurple),
        scrollable: true,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: 'Content',
              ),
              maxLines: null,
            ),
          ],
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop({
                'title': _titleController.text,
                'content': _contentController.text,
              });
            },
            icon: const Icon(Icons.save),
            label: const Text('Save'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close),
            label: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

