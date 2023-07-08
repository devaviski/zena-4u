import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zena_foru/data/data.dart';
import 'package:zena_foru/model/category.dart';
import 'package:zena_foru/model/country.dart';
import 'package:zena_foru/widgets/drawer_header.dart';
import 'package:zena_foru/widgets/drawer_item_list.dart';
import 'package:zena_foru/widgets/drawer_listtile.dart';
import 'package:zena_foru/widgets/social.dart';
import 'package:zena_foru/widgets/weather_drawer.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({
    super.key,
    required this.onPageRefresh,
    this.cityData,
    this.weatherData,
  });
  final void Function({Country? country, Category? category}) onPageRefresh;
  final List<Map<String, dynamic>>? cityData;
  final Map<String, dynamic>? weatherData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      backgroundColor:
          Theme.of(context).colorScheme.brightness == Brightness.dark
              ? Theme.of(context).colorScheme.onSecondary
              : Theme.of(context).colorScheme.secondaryContainer,
      width: max(300, MediaQuery.of(context).size.width - 50),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const MainDrawerHeader(),
                  cityData == null || weatherData == null
                      ? const SizedBox()
                      : WeatherDrawer(
                          cityData: cityData!,
                          weatherData: weatherData!,
                        ),
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
          Social(),
        ],
      ),
    );
  }
}
