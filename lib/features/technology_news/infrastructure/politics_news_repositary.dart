import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/features/technology_news/domain/politics_news_model.dart';

class PoliticsNewsRepositary {
  Future<PoliticsNewsModel> fetchPoliticsNews(
      {required String categories}) async {
    final String apiUrl =
        'https://newsdata.io/api/1/latest?country=np&category=$categories&apikey=pub_50287abdfee2a9481d4a5fa7efd921cde4900';
    final response = await http.get(Uri.parse(apiUrl));

    try {
      if (response.statusCode == 200) {
        final data = PoliticsNewsModel.fromJson(json.decode(response.body));
        return data;
      } else {
        throw Exception('Failed to load latest news');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
