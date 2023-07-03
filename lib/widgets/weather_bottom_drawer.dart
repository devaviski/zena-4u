import 'package:flutter/material.dart';

class WeatherBottomDrawer extends StatelessWidget {
  const WeatherBottomDrawer({
    super.key,
    required this.cityData,
    required this.weatherData,
  });
  final List<Map<String, dynamic>> cityData;
  final Map<String, dynamic> weatherData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.location_city),
      title: Text(cityData[0]['state']),
      subtitle: Text(
        cityData[0]['name'],
      ),
      trailing: SizedBox(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              'https://openweathermap.org/img/wn/${weatherData!['icon']}@2x.png',
              width: 52,
              height: 52,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: "${weatherData['temp'].round()} ",
                      style: textStyle(context)),
                  WidgetSpan(
                    child: Transform.translate(
                      offset: const Offset(2, -8),
                      child: Text(
                        'o',
                        //superscript is usually smaller in size
                        textScaleFactor: 0.7,
                        style: textStyle(context),
                      ),
                    ),
                  ),
                  TextSpan(text: "c", style: textStyle(context)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

TextStyle? textStyle(context) => Theme.of(context).textTheme.titleMedium;
