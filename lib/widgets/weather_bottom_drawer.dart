import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherBottomDrawer extends ConsumerWidget {
  const WeatherBottomDrawer({super.key, required this.cityData});
  final List<Map<String, dynamic>> cityData;
  // bool _notset = true;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.location_city),
      title: Text(cityData[0]['state']),
      subtitle: Text(cityData[0]['name']),
      trailing: Container(
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.dry),
            SizedBox(
              width: 2,
            ),
            Text('23'),
          ],
        ),
      ),
    );
  }
}
  

      
    //   child: ListTile(
    //     leading: Icon(Icons.location_city),
    //     title: Text(cityData[0]['state']),
    //     subtitle: Text(cityData[0]['name']),
    //     trailing: Container(
    //       child: Row(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Icon(Icons.dry),
    //           SizedBox(
    //             width: 2,
    //           ),
    //           Text('23'),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  

