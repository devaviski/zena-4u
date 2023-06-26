import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zena_foru/model/country.dart';
import 'package:zena_foru/providers/active_category_provider.dart';
import 'package:zena_foru/providers/active_country_provider.dart';
import 'package:zena_foru/providers/news_provider.dart';

class DrawerListTile extends ConsumerWidget {
  const DrawerListTile({
    super.key,
    required this.country,
    this.leftPadding,
    required this.onCountryCahnge,
  });
  final Country country;
  final EdgeInsets? leftPadding;
  final void Function(Future<void>) onCountryCahnge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeCountry = ref.watch(activeCountryProvider);
    final activeCategory = ref.watch(activeCategoryProvider);
    return ListTile(
      contentPadding: leftPadding,
      title: Text(country.fullName),
      selected: country.shortName == activeCountry,
      selectedColor: Colors.orange,
      onTap: () {
        Navigator.of(context).pop();
        ref.read(activeCountryProvider.notifier).setCountry(country.shortName);
        onCountryCahnge(ref
            .read(newsProvider.notifier)
            .fetchNews(country: country.shortName, category: activeCategory));
      },
    );
  }
}
