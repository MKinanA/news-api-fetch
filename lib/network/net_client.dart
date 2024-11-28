import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:news_api_fetch/models/news.dart';

class NetClient { // Network client optimized for the news API
  static Future<List<News>> fetchNews({required String portal, String? category, bool kDebugMode = false}) async {
    (kDebugMode ? print : log)('Fetching news from portal "$portal" and category "${category ?? ''}"');
    final String url = 'https://berita-indo-api-next.vercel.app/api/$portal${category != null ? '/$category' : ''}';
    (kDebugMode ? print : log)('URL: $url');
    final http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      (kDebugMode ? print : log)('Response status code: ${response.statusCode}${kDebugMode ? ',\nResponse body: ${response.body}' : ''}');
      throw Exception('Response status code: ${response.statusCode}${kDebugMode ? ',\nResponse body: ${response.body}' : ''}');
    }
    final dynamic data = jsonDecode(response.body);
    (kDebugMode ? print : log)('Retrieved response data type is ${data.runtimeType}');
    final List<News> result = [];
    if (data is Map && data['data'] is List && data['data'].length > 0 && data['data'].fold(true, (prev, element) => prev ? element is Map : false)) {
      for (Map news in data['data']) {
        News properNews = News({});
        news.forEach((key, value) {
          if (key is String) {
            String properKey = key;
            properNews[properKey] = value;
          }
        });
        result.add(properNews);
      }
    } else {
      throw Exception('Unrecognized response from API${kDebugMode ? ',\nResponse body: ${response.body}' : ''}');
    }
    (kDebugMode ? print : log)('API response data parsed, returning');
    return result;
  }
}
