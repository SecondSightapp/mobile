import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secondsight/src/ui/themes/source_colors.dart';
import '../../data/entries.dart';
import 'package:secondsight/src/data/journal_entry.dart';
import 'package:secondsight/src/data/moods.dart';
import 'package:secondsight/src/data/mood_state.dart';
import 'package:secondsight/src/constants.dart';
import '../../data/mood_star.dart';

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

  final List<MoodStar> _moodLog = [];

  Future<void> getMoods() async {
    try {
      final moods = await MoodService.getStars(); 
      setState(() {
        _moodLog.addAll(moods); 
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load moods: $e')),
      );
    }
  }

  String getMoodForDate(DateTime date) {
    DateTime dateUtc = DateTime.utc(date.year, date.month, date.day);
    MoodStar? mood = _moodLog.firstWhere((mood) => DateTime.utc(mood.date.year, mood.date.month, mood.date.day) == dateUtc, orElse: () => MoodStar(date: dateUtc, mood: "neutral"));
    return mood.mood.toString();
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
                onPressed: (_isTitleEmpty || _isDescriptionEmpty) ? null : () async {
                  if (!_isTitleEmpty && !_isDescriptionEmpty) {
                    try {
                      await NoteService.createEntry(
                        _titleController.text, 
                        _descriptionController.text,
                      );
                      Navigator.pop(context);
                    } catch (error) {
                      print('Failed to create note: $error');
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Error'),
                          content: const Text('Failed to create note. Please try again later.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
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
