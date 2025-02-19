import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/features/sports_news/domain/sport_news_model.dart';

class SportNewsRepositary {
  Future<SportNewsModel> fetchSportNews(String? pagenumber) async {
    // Set pagenumber to null if it's an empty string
    final page = pagenumber?.isEmpty ?? true ? null : pagenumber;

    // Construct API URL conditionally
    final String apiUrl = page == null
        ? 'https://newsdata.io/api/1/latest?country=np&apikey=pub_50287abdfee2a9481d4a5fa7efd921cde4900'
        : 'https://newsdata.io/api/1/latest?country=np&apikey=pub_50287abdfee2a9481d4a5fa7efd921cde4900&page=$page';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = SportNewsModel.fromJson(json.decode(response.body));
      return data;
    } else {
      throw Exception('Failed to load latest news');
    }
  }
}
