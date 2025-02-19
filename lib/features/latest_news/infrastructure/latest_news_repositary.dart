import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/features/latest_news/domain/latest_news_model.dart';

class LatestNewsRepositary {
  final String apiUrl =
      "https://newsdata.io/api/1/latest?country=np&apikey=pub_50287abdfee2a9481d4a5fa7efd921cde4900";

  Future<LatestNewsModel> fetchLatestNews() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = LatestNewsModel.fromJson(json.decode(response.body));
      return data;
    } else {
      throw Exception('Failed to load latest news');
    }
  }
}
