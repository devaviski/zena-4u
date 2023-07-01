// import 'dart:convert' as convert;
// import 'dart:io';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;
// import 'package:zena_foru/model/news.dart';
// import 'package:zena_foru/utils/constants.dart';

// class NewsNotifier extends StateNotifier<Map<String, List<News>>> {
//   NewsNotifier() : super({});

//   Future<void> loadNews({
//     required String query,
//   }) async {
//     final client = http.Client();
//     try {
//       final url = Uri(
//         scheme: 'https',
//         host: 'newsapi.org',
//         path: '/v2/everything',
//         queryParameters: {
//           'language': 'en',
//           'q': query,
//           'from': dateFormatter
//               .format(DateTime.now().subtract(const Duration(days: 5))),
//           'sortBy': 'popularity',
//         },
//       );

//       final urlTrending = Uri(
//         scheme: 'https',
//         host: 'newsapi.org',
//         path: '/v2/top-headlines',
//         queryParameters: {
//           'language': 'en',
//           'country': 'us',
//         },
//       );
//       // davortes2:0bafbbb4b0e544c7a905c768f33f54b6
//       //dawit:62be7b5997b346e098f0f10724c7a06e
//       var response = await client.get(
//         url,
//         headers: {
//           HttpHeaders.authorizationHeader: '62be7b5997b346e098f0f10724c7a06e',
//         },
//       );
//       var responseTrending = await client.get(
//         urlTrending,
//         headers: {
//           HttpHeaders.authorizationHeader: '62be7b5997b346e098f0f10724c7a06e',
//         },
//       );
//       if (response.statusCode == 200) {
//         state = {
//           ...state,
//           'normal': jsonToModel(
//             convert.jsonDecode(response.body) as Map<String, dynamic>,
//           )
//         };
//       } else {
//         print('Request failed with status: ${response.statusCode}.');
//       }
//       if (responseTrending.statusCode == 200) {
//         state = {
//           ...state,
//           'trending': jsonToModel(
//             convert.jsonDecode(responseTrending.body) as Map<String, dynamic>,
//           )
//         };
//       } else {
//         print('Request failed with status: ${responseTrending.statusCode}.');
//       }
//     } catch (e) {
//       print('Something wrong: $e');
//     } finally {
//       client.close();
//     }
//   }
// }

// final newsProvider =
//     StateNotifierProvider<NewsNotifier, Map<String, List<News>>>(
//         (ref) => NewsNotifier());

// List<News> jsonToModel(response) {
//   return (response['articles'] as List<dynamic>).map((article) {
//     final news = article as Map<String, dynamic>;
//     return News(
//         source: news['source'],
//         author: news['author'],
//         title: news['title'],
//         description: news['description'],
//         url: news['url'],
//         urlToImage: news['urlToImage'],
//         publishAt: news['publishedAt'],
//         content: news['content']);
//   }).toList();
// }
