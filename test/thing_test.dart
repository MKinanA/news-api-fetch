import 'package:flutter_test/flutter_test.dart';
import 'package:news_api_fetch/network/net_client.dart';
import 'package:news_api_fetch/provider/news_data.dart';

void main() {
  group('Network Test(s)', () {
    test('Fetch News', () async {
      final result = await NetClient.fetchNews(portal: 'cnn-news', category: 'nasional', kDebugMode: true);
      expect(result, (thing) => thing.isNotEmpty == true);
    });
  });
  group('State Management Test', () {
    test('Fetch News using Provider', () async {
      final newsData = NewsData();
      await newsData.fetch(portal: 'cnn-news', category: 'ekonomi', kDebugMode: true); // Initial fetch
      final result = await newsData.get(portal: 'cnn-news', category: 'ekonomi', kDebugMode: true); // getting after fetching
      await newsData.update(portal: 'cnn-news', category: 'ekonomi', kDebugMode: true);
      expect(result, (thing) => thing.isNotEmpty == true);
    });
  });
}
