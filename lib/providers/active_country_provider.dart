import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActiveCountryNotifier extends StateNotifier<String> {
  ActiveCountryNotifier() : super('us');

  Future<void> setCountry(String ctry) async {
    state = ctry;
  }
}

final activeCountryProvider =
    StateNotifierProvider<ActiveCountryNotifier, String>(
        (ref) => ActiveCountryNotifier());
