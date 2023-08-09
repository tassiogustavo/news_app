import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/model/news.dart';

class ApiService {
  static Future<List<News>> fetchDataFromAPI(String keyWorld) async {
    String url =
        'https://newsapi.org/v2/everything?q=$keyWorld&apiKey=1a08ab76da8548bebc4fbc9f0854b27b';
    final response = await http.get(Uri.parse(url));

    final news = <News>[];

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);

      for (int i = 0; i < (data['articles'] as List<dynamic>).length; i++) {
        news.add(
          News(
            sourceName: data['articles'][i]['source']['name'] ?? 'Sem Registro',
            author: data['articles'][i]['author'] ?? 'Sem Registro',
            title: data['articles'][i]['title'] ?? 'Sem Registro',
            description: data['articles'][i]['description'] ?? 'Sem Registro',
            url: data['articles'][i]['url'] ?? 'Sem Registro',
            urlToImage: data['articles'][i]['urlToImage'] ??
                'https://st3.depositphotos.com/3223379/13698/i/600/depositphotos_136985036-stock-photo-words-news-on-digital-blue.jpg',
            publishedAt: data['articles'][i]['publishedAt'] ?? 'Sem Registro',
            content: data['articles'][i]['content'] ?? 'Sem Registro',
          ),
        );
      }

      return news;
    } else {
      throw Exception('Failed to fetch data from API');
    }
  }
}
