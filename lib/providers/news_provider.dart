import 'dart:convert' as convert;
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:zena_foru/model/category.dart';
import 'package:zena_foru/model/country.dart';
import 'package:zena_foru/model/news.dart';

class NewsNotifier extends StateNotifier<List<News>> {
  NewsNotifier() : super([]);

  Future<void> fetchNews(
    Country? country,
    Category category,
  ) async {
    var querryParams = {'language': 'en', 'category': category.category.name};

    if (country != null && country.shortName == null) {
      querryParams = {
        ...querryParams,
        'country': country.shortName as String,
      };
    }
    final url = Uri(
        scheme: 'https',
        host: 'newsapi.org',
        path: '/v2/top-headlines',
        queryParameters: querryParams);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: '62be7b5997b346e098f0f10724c7a06e',
    });
    if (response.statusCode == 200) {
      state = jsonToModel(
          convert.jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}

final newsProvider =
    StateNotifierProvider<NewsNotifier, List<News>>((ref) => NewsNotifier());

List<News> jsonToModel(response) {
  return (response['articles'] as List<dynamic>).map((article) {
    final news = article as Map<String, dynamic>;
    return News(
        source: news['source'],
        author: news['author'],
        title: news['title'],
        description: news['description'],
        url: news['url'],
        urlToImage: news['urlToImage'],
        publishAt: news['publishedAt'],
        content: news['content']);
  }).toList();
}
