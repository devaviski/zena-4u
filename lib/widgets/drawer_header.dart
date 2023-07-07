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
      child: Column(
        children: [
          Expanded(
            child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(50),
                  shape: BoxShape.circle,
                ),
                child: Image.asset('assets\\icons\\play_store_512.png')),
          ),
          const SizedBox(height: 4),
          Text('Zena-4u'),
          const SizedBox(height: 8),
          Text('Update your information by this application')
        ],
      ),
    );
  }
}
