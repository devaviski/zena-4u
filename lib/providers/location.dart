import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

class LocationNotifier extends StateNotifier<LocationData?> {
  LocationNotifier() : super(null);
  final Location location = Location();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;

  init() async {
    try {
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
      state = await location.getLocation();
    } catch (e) {}
  }
}

final locationDataProvider =
    StateNotifierProvider<LocationNotifier, LocationData?>(
        (ref) => LocationNotifier());
