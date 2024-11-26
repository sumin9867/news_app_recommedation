import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/features/search/domain/search_news_model.dart';

class SearchNewsRepositary {
  Future<SearchNewsModel> fetchSearchNewsRepositaryNews(
      String? pagenumber) async {
    // Set pagenumber to null if it's an empty string
    final page = pagenumber?.isEmpty ?? true ? null : pagenumber;

    // Construct API URL conditionally
    final String apiUrl = page == null
        ? 'https://newsdata.io/api/1/news?apikey=pub_50287abdfee2a9481d4a5fa7efd921cde4900&q=all'
        : 'https://newsdata.io/api/1/news?apikey=pub_50287abdfee2a9481d4a5fa7efd921cde4900&q=all&page=$page';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = SearchNewsModel.fromJson(json.decode(response.body));
      return data;
    } else {
      throw Exception('Failed to load latest news');
    }
  }
}
