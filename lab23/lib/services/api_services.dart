import 'dart:convert';
import 'package:http/http.dart' as http;

class JokeApiService {
  static const String baseUrl = 'https://official-joke-api.appspot.com';

  static Future<List<Map<String, dynamic>>> getJokesByType(String type) async {
    final response = await http.get(Uri.parse('$baseUrl/jokes/$type/ten'));

    if (response.statusCode == 200) {
      List<dynamic> jokes = json.decode(response.body);
      return jokes.map((joke) => joke as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load jokes');
    }
  }

  static Future<Map<String, dynamic>> getRandomJoke() async {
    final response = await http.get(Uri.parse('$baseUrl/random_joke'));

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load random joke');
    }
  }

  static Future<List<String>> getJokeTypes() async {
    final response = await http.get(Uri.parse('$baseUrl/types'));

    if (response.statusCode == 200) {
      List<dynamic> types = json.decode(response.body);
      return types.cast<String>();
    } else {
      throw Exception('Failed to load joke types');
    }
  }
}
