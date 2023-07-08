import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_settings/open_settings.dart';
import 'package:zena_foru/providers/http_fetch_provider.dart';
import 'package:zena_foru/providers/location.dart';
import 'package:zena_foru/providers/weather_provider.dart';
import 'package:zena_foru/screens/home_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  // late Future<void> _initialState;
  late bool _isLoading;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _fetchAllDatas();
  }

  _fetchAllDatas() async {
    _isLoading = true;
    _timer = Timer(Duration(seconds: 10), () {
      ScaffoldMessenger.of(context)
          .showSnackBar(
            SnackBar(
              // action: SnackBarAction(
              //   label: 'Ok',
              //   onPressed: () async {
              //     await OpenSettings.openWIFISetting();
              //     setState(() {
              //       _fetchAllDatas();
              //     });
              //   },
              // ),
              duration: Duration(seconds: 10),
              content: Text(
                  'There is network problem! Please connect to the Internet.'),
            ),
          )
          .closed
          .then(
        (reason) {
          if (reason == SnackBarClosedReason.timeout) {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          }
        },
      );
    });
    await ref.read(locationDataProvider.notifier).init();
    await ref.read(apisFetchProvider.notifier).fetchAPIsData(
      headlineParams: {'country': 'us'},
      everythingsQuery: '"USA"',
    );
    final locationData = ref.watch(locationDataProvider);
    await ref.read(weatherProvider.notifier).fetchWeather(
        {'lat': locationData!.latitude!, 'lon': locationData.longitude!});
    setState(() {
      _isLoading = false;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Image.asset(
                        'assets\\icons\\play_store_512.png',
                        width: 92,
                        height: 92,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Zena 4u',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Loading...',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      _timer.cancel();
      ScaffoldMessenger.of(context).clearSnackBars();
      return HomeScreen();
    }
  }
}
