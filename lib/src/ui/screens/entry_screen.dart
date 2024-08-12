import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secondsight/src/ui/themes/source_colors.dart';
import 'package:secondsight/src/data/journal_entry.dart';
import 'package:secondsight/src/data/entries.dart';
import 'package:secondsight/src/data/moods.dart';
import 'package:secondsight/src/data/mood_state.dart';
import 'package:secondsight/src/constants.dart';

class CreateEntryScreen extends StatefulWidget {
  const CreateEntryScreen({super.key});

  @override
  State<CreateEntryScreen> createState() => _CreateEntryScreenState();
}

class _CreateEntryScreenState extends State<CreateEntryScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _isTitleEmpty = true;
  bool _isDescriptionEmpty = true;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_validateFields);
    _descriptionController.addListener(_validateFields);
  }

  void _validateFields() {
    setState(() {
      _isTitleEmpty = _titleController.text.isEmpty;
      _isDescriptionEmpty = _descriptionController.text.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create New Entry",
          style: GoogleFonts.lexend(
            textStyle: const TextStyle(
              color: Color.fromRGBO(209, 196, 197, 1),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        backgroundColor: themePurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title',
              style: GoogleFonts.lexend(
                textStyle: const TextStyle(
                  color: themePurple,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
              ),
              style: GoogleFonts.lexend(),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Content',
              style: GoogleFonts.lexend(
                textStyle: const TextStyle(
                  color: themePurple,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              ),
              maxLines: 18,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              style: GoogleFonts.lexend(),
            ),
            const SizedBox(height: 24.0),
            Center(
              child: ElevatedButton(
                onPressed: (_isTitleEmpty || _isDescriptionEmpty) ? null : () {
                  if (!_isTitleEmpty && !_isDescriptionEmpty) {
                    DateTime today = DateTime.now();
                    String dateString = today.toIso8601String().split('T').first;
                    final newEntry = {
                      'title': _titleController.text,
                      'description': _descriptionController.text,
                      'color': moods[moodState.moodLog[DateTime.utc(today.year, today.month, today.day)]],
                      'date': '${dateString.substring(5, 7)}/${dateString.substring(8, 10)}/${dateString.substring(0, 4)}',
                    };
                    Navigator.pop(context, newEntry);
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                  textStyle: GoogleFonts.lexend(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                child: const Text('Create Entry'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.removeListener(_validateFields);
    _descriptionController.removeListener(_validateFields);
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
