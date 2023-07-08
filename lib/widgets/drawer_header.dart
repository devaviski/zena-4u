import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainDrawerHeader extends ConsumerStatefulWidget {
  const MainDrawerHeader({
    super.key,
  });

  @override
  ConsumerState<MainDrawerHeader> createState() => _MainDrawerHeaderState();
}

class _MainDrawerHeaderState extends ConsumerState<MainDrawerHeader> {
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          Expanded(
            child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Image.asset('assets\\icons\\play_store_512.png')),
          ),
          const SizedBox(height: 4),
          Text(
            'Zena-4u',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            child: Text(
              'News App prepared for lesson purpose!\n👌👌👌',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
