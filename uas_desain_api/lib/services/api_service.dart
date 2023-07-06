import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/news_model.dart';

class ApiService {
  final String apiUrl =
      'https://berita-indo-api.vercel.app/v1/cnn-news/hiburan';

  Future<List<NewsModel>> getNews() async {
    final response = await http.get(Uri.parse(apiUrl));
    // ignore: unnecessary_null_comparison
    if (response.body != null) {
      final parsed = jsonDecode(response.body)["data"];
      List<NewsModel> news =
          parsed.map<NewsModel>((json) => NewsModel.fromJson(json)).toList();
      return news;
    } else {
      throw Exception('Failed to load news');
    }
  }
}
