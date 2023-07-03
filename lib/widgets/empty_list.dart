import 'package:flutter/material.dart';
import 'package:zena_foru/data/data.dart';
import 'package:zena_foru/model/category.dart';
import 'package:zena_foru/model/country.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key, required this.onPageRefresh});
  final void Function({Country? country, Category? category}) onPageRefresh;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        children: [
          const Icon(
            Icons.newspaper,
            size: 56,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'There is no a story for this Category!',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    onPageRefresh(country: usas[0], category: categories[0]);
                  },
                  child: const Text('Back to home')),
              TextButton(
                  onPressed: () {
                    onPageRefresh();
                  },
                  child: const Text('Try Agin')),
            ],
          )
        ],
      ),
    );
  }
}
