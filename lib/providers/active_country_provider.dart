import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zena_foru/model/country.dart';

class ActiveCountryNotifier extends StateNotifier<Country?> {
  ActiveCountryNotifier() : super(null);

  Future<void> setCountry(Country ctry) async {
    state = ctry;
  }
}

final activeCountryProvider =
    StateNotifierProvider<ActiveCountryNotifier, Country?>(
        (ref) => ActiveCountryNotifier());
