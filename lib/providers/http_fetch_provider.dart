import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:zena_foru/model/news.dart';
import 'package:zena_foru/utils/constants.dart';
import 'dart:convert' as convert;

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

class HttpRequestNotifier extends StateNotifier<Map<String, String>> {
  HttpRequestNotifier() : super({});

  Future<void> fetchAPIsData({
    Map<String, String>? headlineParams,
    String? everythingsQuery,
    Map<String, double>? locationData,
  }) async {
    final httpClient = http.Client();
    try {
      if (headlineParams != null) {
        final url = Uri(
          scheme: 'https',
          host: 'newsapi.org',
          path: '/v2/top-headlines',
          queryParameters: {
            'language': 'en',
            ...headlineParams,
          },
        );
        final response = await httpClient.get(
          url,
          headers: {
            // HttpHeaders.authorizationHeader: '62be7b5997b346e098f0f10724c7a06e',
            HttpHeaders.authorizationHeader: '0bafbbb4b0e544c7a905c768f33f54b6',
          },
        );
        if (response.statusCode == 200) {
          state = {...state, 'headlines': response.body};
        } else {
          print(
              'Request failed for headlines fetch with status: ${response.statusCode}.');
        }
      }
      if (everythingsQuery != null) {
        final url = Uri(
          scheme: 'https',
          host: 'newsapi.org',
          path: '/v2/everything',
          queryParameters: {
            'language': 'en',
            'q': everythingsQuery,
            'from': dateFormatter
                .format(DateTime.now().subtract(const Duration(days: 5))),
            'sortBy': 'popularity',
          },
        );
        final response = await httpClient.get(
          url,
          headers: {
            // HttpHeaders.authorizationHeader: '62be7b5997b346e098f0f10724c7a06e',
            HttpHeaders.authorizationHeader: '0bafbbb4b0e544c7a905c768f33f54b6',
          },
        );
        if (response.statusCode == 200) {
          state = {...state, 'everything': response.body};
        } else {
          print(
              'Request failed for everything fetch with status: ${response.statusCode}.');
        }
      }
      if (locationData != null) {
        final url = Uri.parse(
            'http://api.openweathermap.org/geo/1.0/reverse?lat=${locationData['lat']}&lon=${locationData['lon']}&appid=ad04899fa6b16c37350b1dd53926353e');
        final response = await http.get(url);
        if (response.statusCode == 200) {
          state = {...state, 'location': response.body};
        } else {
          print(
              'Request failed for geolocation fetch with status: ${response.statusCode}.');
        }
      }
    } finally {
      httpClient.close();
    }
  }
}

final apisFetchProvider =
    StateNotifierProvider<HttpRequestNotifier, Map<String, String>>(
        (ref) => HttpRequestNotifier());

final headlinesProvider = Provider((ref) {
  final responseBody = ref.watch(apisFetchProvider)['headlines'];
  final headlines =
      jsonToModel(convert.jsonDecode(responseBody!) as Map<String, dynamic>);
  return headlines;
});
final allNewsProvider = Provider((ref) {
  final responseBody = ref.watch(apisFetchProvider)['everything'];
  final everythings =
      jsonToModel(convert.jsonDecode(responseBody!) as Map<String, dynamic>);
  return everythings;
});
final nearTownProvider = Provider((ref) {
  final responseBody = ref.watch(apisFetchProvider)['location'];
  if (responseBody == null) {
    return null;
  }
  final locationName = (convert.jsonDecode(responseBody) as List<dynamic>)
      .cast<Map<String, dynamic>>();
  return locationName;
});
