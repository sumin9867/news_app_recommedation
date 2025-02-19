import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/features/latest_news/domain/latest_news_model.dart';

class LatestNewsRepositary {
  final String apiUrl =
<<<<<<< HEAD
      "https://newsdata.io/api/1/latest?country=np&apikey=pub_50287abdfee2a9481d4a5fa7efd921cde4900";
=======
      'https://newsdata.io/api/1/latest?country=np&category=top&apikey=pub_49853c50abde83d885bb2f3aba749edf172b4';
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d

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
