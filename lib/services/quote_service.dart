import 'dart:convert';
import 'package:http/http.dart' as http;

class QuoteService {
  Future<Map<String, String>> getRandomQuote() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.quotable.io/random'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {'quote': data['content'], 'author': data['author']};
      } else {
        throw 'Failed to fetch quote';
      }
    } catch (e) {
      throw 'No internet connection';
    }
  }
}
