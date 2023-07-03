import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zena_foru/model/category.dart';
import 'package:zena_foru/model/country.dart';
import 'package:zena_foru/providers/active_country_provider.dart';

class DrawerListTile extends ConsumerWidget {
  const DrawerListTile({
    super.key,
    required this.country,
    this.leftPadding,
    required this.onCountryCahnge,
  });
  final Country country;
  final EdgeInsets? leftPadding;
  final void Function({Country? country, Category? category}) onCountryCahnge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeCountry = ref.watch(activeCountryProvider);
    return ListTile(
      contentPadding: leftPadding,
      title: Text(country.fullName),
      selected: country == activeCountry,
      selectedColor: Colors.orange,
      onTap: () {
        Navigator.of(context).pop();
        onCountryCahnge(
          country: country,
        );
      },
    );
  }
}
