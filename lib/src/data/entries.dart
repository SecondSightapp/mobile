import '../data/journal_entry.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'token.dart';
class NoteService {
  static Future<List<JournalEntry>> getEntries() async {
    final url = 'https://secondsight-backend.onrender.com/notes'; 

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${TokenService.token}', 
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        return responseData.map((json) => JournalEntry.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch notes. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error occurred while fetching notes: $error');
      throw Exception('Error occurred while fetching notes: $error');
    }
  }

  static Future<void> createEntry(String title, String content) async {
    final url = 'https://secondsight-backend.onrender.com/notes'; 

    final noteData = {
      'title': title,
      'content': content,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${TokenService.token}', 
          'Content-Type': 'application/json', 
        },
        body: json.encode(noteData), 
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Note created successfully');
        print('Response body: ${response.body}');
      } else {
        print('Failed to create note. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }

    } catch (error) {
      print('Error occurred while creating note: $error');
      throw Exception('Error occurred while creating note: $error');
    }
  }
}
