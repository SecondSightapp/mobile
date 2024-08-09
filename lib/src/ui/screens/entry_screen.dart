import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secondsight/src/ui/themes/source_colors.dart';

class CreateEntryScreen extends StatefulWidget {
  const CreateEntryScreen({super.key});

  @override
  State<CreateEntryScreen> createState() => _CreateEntryScreenState();
}

class _CreateEntryScreenState extends State<CreateEntryScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final Color _fixedColor = Colors.blue; // needs to depend on mood of day

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
            const Text(
              'Title',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4A4A4A),
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
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4A4A4A),
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
                    final newEntry = {
                      'title': _titleController.text,
                      'description': _descriptionController.text,
                      'color': _fixedColor,
                      'date': DateTime.now().toIso8601String().split('T').first,
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
