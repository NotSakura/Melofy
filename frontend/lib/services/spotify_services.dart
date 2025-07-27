
import 'dart:convert';
import 'package:http/http.dart' as http;

class SpotifyService {
  static Future<Map<String, dynamic>> searchTrack(String query) async {
    final response = await http.get(Uri.parse('https://your-backend-url.com/track?query=\$query'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load track');
    }

    return jsonDecode(response.body);
  }
}