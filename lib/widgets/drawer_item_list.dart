import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zena_foru/model/category.dart';
import 'package:zena_foru/model/country.dart';
import 'package:zena_foru/providers/active_country_provider.dart';
import 'package:zena_foru/widgets/drawer_listtile.dart';

class DrawerItemList extends ConsumerStatefulWidget {
  const DrawerItemList({
    super.key,
    required this.countries,
    required this.continentName,
    required this.onCountryCahnge,
  });
  final List<Country> countries;
  final String continentName;
  final void Function({Country? country, Category? category}) onCountryCahnge;

  @override
  ConsumerState<DrawerItemList> createState() => _DrawerItemListState();
}

class _DrawerItemListState extends ConsumerState<DrawerItemList> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final activeCountry = ref.watch(activeCountryProvider);
    for (final country in widget.countries) {
      if (country == activeCountry) {
        _isExpanded = true;
        break;
      }
    }
    return Column(
      children: [
        ListTile(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          title: Text(widget.continentName),
          trailing: Icon(
            !_isExpanded ? Icons.arrow_drop_down : Icons.arrow_drop_up,
            size: 36,
          ),
        ),
        !_isExpanded
            ? const SizedBox()
            : Column(
                children: widget.countries
                    .map(
                      (country) => DrawerListTile(
                        country: country,
                        leftPadding: const EdgeInsets.only(left: 32),
                        onCountryCahnge: widget.onCountryCahnge,
                      ),
                    )
                    .toList(),
              ),
      ],
    );
  }
}
