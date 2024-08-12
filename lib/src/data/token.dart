import 'package:http/http.dart' as http;
import 'dart:convert';

class TokenService {
  static String _token = '';

  static void setToken(String token) {
    _token = token;
    print("Recieved token");
  } 

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

