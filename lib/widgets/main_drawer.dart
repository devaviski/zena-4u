import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zena_foru/data/data.dart';
import 'package:zena_foru/widgets/drawer_item_list.dart';
import 'package:zena_foru/widgets/drawer_listtile.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key, required this.onPageRefresh});
  final void Function(Future<void> initialState) onPageRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              child: Text(
                'News App',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
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
    );
  }
}
