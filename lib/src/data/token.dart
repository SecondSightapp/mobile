import 'package:http/http.dart' as http;
import 'dart:convert';

class TokenService {
  static String _token = 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJqdWFucGFwb2xvMTIzQGdtYWlsLmNvbSIsImlhdCI6MTcyMzQzMjY5NCwiZXhwIjoxNzIzNDM0NDk0fQ.Z6nHdy56iHVVs9n3tVk28qbuDBUI4ILwwLvDotxNRKR_XTAwXpB97lNdTA6eajXDS-56vQ1J5JMYq8LAlxhkuw';

  static Future<void> fetchToken() async {
    final url = 'https://secondsight-backend.onrender.com/authenticate';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        // token or empty string, we could do if string empty user cant log in to homepage maybe
        _token = responseData['token'] ?? '';
      } else {
        throw Exception('failed :( with status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('error fetching the token: $error');
    }
  }

  // getter for token
  static String get token => _token;
}

