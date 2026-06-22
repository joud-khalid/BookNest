import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_keys.dart';

class GoogleBooksService {
  static Future<List<Map<String, dynamic>>> searchBooks(
    String query,
  ) async {
    final url = Uri.parse(
      'https://www.googleapis.com/books/v1/volumes'
      '?q=${Uri.encodeComponent(query)}'
      '&key=${ApiKeys.googleBooksApiKey}',
    );

    final response = await http.get(url);
    print("🔍 URL: $url");
print("📡 Status Code: ${response.statusCode}");
print("📦 Response: ${response.body}");

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load books (${response.statusCode})',
      );
    }

    final data = jsonDecode(response.body);

    if (data['items'] == null) {
      return [];
    }

    return List<Map<String, dynamic>>.from(
      data['items'].map((item) {
        final volumeInfo = item['volumeInfo'];
        print(volumeInfo['imageLinks']);

        return {
          'title':
              volumeInfo['title'] ?? 'Unknown Title',

          'author':
              (volumeInfo['authors'] != null &&
                      volumeInfo['authors'].isNotEmpty)
                  ? volumeInfo['authors'][0]
                  : 'Unknown Author',

          'pages':
              volumeInfo['pageCount'] ?? 0,

          'cover':
    (volumeInfo['imageLinks']?['thumbnail'] ?? '')
        .replaceAll('http://', 'https://')
        .replaceAll('zoom=1', 'zoom=5'),
        };
      }),
    );
  }
}