import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zena_foru/data/data.dart';
import 'package:zena_foru/model/category.dart';
import 'package:zena_foru/model/country.dart';
import 'package:zena_foru/widgets/drawer_header_with_weather.dart';
import 'package:zena_foru/widgets/drawer_item_list.dart';
import 'package:zena_foru/widgets/drawer_listtile.dart';
import 'package:zena_foru/widgets/weather_bottom_drawer.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({
    super.key,
    required this.onPageRefresh,
    required this.cityData,
    required this.weatherData,
  });
  final void Function({Country? country, Category? category}) onPageRefresh;
  final List<Map<String, dynamic>>? cityData;
  final Map<String, dynamic>? weatherData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const DrawerHeaderWithWeather(),
                  ...continents.entries.map((continent) {
                    if (continent.value.countries.length == 1) {
                      return DrawerListTile(
                        country: continent.value.countries[0],
                        onCountryCahnge: onPageRefresh,
                      );
                    }
                    return DrawerItemList(
                      countries: continent.value.countries,
                      continentName: continent.value.name,
                      onCountryCahnge: onPageRefresh,
                    );
                  })
                ],
              ),
            ),
          ),
          cityData == null
              ? const SizedBox()
              : WeatherBottomDrawer(
                  cityData: cityData!,
                  weatherData: weatherData!,
                ),
        ],
      ),
    );
  }
}
