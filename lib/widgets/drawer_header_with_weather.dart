import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrawerHeaderWithWeather extends ConsumerStatefulWidget {
  const DrawerHeaderWithWeather({
    super.key,
  });

  @override
  ConsumerState<DrawerHeaderWithWeather> createState() =>
      _DrawerHeaderWithWeatherState();
}

class _DrawerHeaderWithWeatherState
    extends ConsumerState<DrawerHeaderWithWeather> {
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Text(''),
    );
  }
}
