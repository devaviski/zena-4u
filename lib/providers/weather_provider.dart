import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:zena_foru/providers/http_fetch_provider.dart';
import 'package:zena_foru/utils/secrets.dart';
import 'dart:convert' as convert;

class WeatherNotifier extends StateNotifier<Map<String, String>> {
  WeatherNotifier() : super({});
  fetchWeather(
    Map<String, double> locationData,
  ) async {
    final httpClient = http.Client();
    try {
      final url = Uri.parse(
          'http://api.openweathermap.org/geo/1.0/reverse?lat=${locationData['lat']}&lon=${locationData['lon']}&appid=$openWeatherMapApi');
      final response = await httpClient.get(url);
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
    } catch (e) {
      print('Somerthing wrong happened!');
    } finally {
      httpClient.close();
    }
  }
}

final weatherProvider =
    StateNotifierProvider<WeatherNotifier, Map<String, String>>(
        (ref) => WeatherNotifier());

final nearTownProvider = Provider(
  (ref) {
    final response = ref.watch(weatherProvider);
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
  },
);

final weatherDataProvider = Provider((ref) {
  final response = ref.watch(weatherProvider);
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
