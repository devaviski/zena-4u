import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:zena_foru/model/news.dart';
import 'package:zena_foru/utils/constants.dart';
import 'dart:convert' as convert;

import 'package:zena_foru/utils/secrets.dart';

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
      if (locationData != null) {
        final url = Uri.parse(
            'http://api.openweathermap.org/geo/1.0/reverse?lat=${locationData['lat']}&lon=${locationData['lon']}&appid=$openWeatherMapApi');
        final response = await http.get(url);
        if (response.statusCode == 200) {
          state = {...state, 'location': response.body};
        } else {
          print(
              'Request failed for geolocation fetch with status: ${response.statusCode}.');
        }
        final urlWeather = Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?units=metric&lat=${locationData['lat']}&lon=${locationData['lon']}&appid=$openWeatherMapApi');
        final responseWeather = await httpClient.get(urlWeather);
        if (responseWeather.statusCode == 200) {
          state = {...state, 'weather': responseWeather.body};
        } else {
          print(
              'Request failed for weather fetch with status: ${responseWeather.statusCode}.');
        }
      }
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
            HttpHeaders.authorizationHeader: newsApiDagi,
            // HttpHeaders.authorizationHeader: newsApiDawit,
            // HttpHeaders.authorizationHeader: newsApiDavortes,
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
                .format(DateTime.now().subtract(const Duration(days: 3))),
            'sortBy': 'popularity',
          },
        );
        final response = await httpClient.get(
          url,
          headers: {
            HttpHeaders.authorizationHeader: newsApiDagi,

            // HttpHeaders.authorizationHeader: newsApiDawit,
            // HttpHeaders.authorizationHeader: newsApiDavortes,
          },
        );
        if (response.statusCode == 200) {
          state = {...state, 'everything': response.body};
        } else {
          print(
              'Request failed for everything fetch with status: ${response.statusCode}.');
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
  final response = ref.watch(apisFetchProvider);
  if (!response.containsKey('headlines')) {
    return null;
  }
  final responseBody = response['headlines'];
  final headlines =
      jsonToModel(convert.jsonDecode(responseBody!) as Map<String, dynamic>);
  return headlines;
});
final allNewsProvider = Provider((ref) {
  final response = ref.watch(apisFetchProvider);
  if (!response.containsKey('everything')) {
    return null;
  }
  final responseBody = response['everything'];
  final everythings =
      jsonToModel(convert.jsonDecode(responseBody!) as Map<String, dynamic>);
  return everythings;
});
final nearTownProvider = Provider((ref) {
  final response = ref.watch(apisFetchProvider);
  if (!response.containsKey('location')) {
    return null;
  }
  final responseBody = response['location'];
  if (responseBody == null) {
    return null;
  }
  final locationName = (convert.jsonDecode(responseBody) as List<dynamic>)
      .cast<Map<String, dynamic>>();
  return locationName;
});

final weatherProvider = Provider((ref) {
  final response = ref.watch(apisFetchProvider);
  if (!response.containsKey('weather')) {
    return null;
  }
  final responseBody = response['weather'];
  if (responseBody == null) {
    return null;
  }
  final weatherData =
      (convert.jsonDecode(responseBody) as Map<String, dynamic>);
  final weatherTemprature = weatherData['main']['temp'];
  final weatherIcon = weatherData['weather'][0]['icon'];
  return {
    'temp': weatherTemprature,
    'icon': weatherIcon,
  };
});
