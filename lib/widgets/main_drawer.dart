import 'package:flutter/material.dart';
import 'package:zena_foru/data/data.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
            ...countries.map(
              (country) => ListTile(
                leading: Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: RadialGradient(
                      colors: [
                        Colors.orange.withOpacity(0.1),
                        Colors.orange.withOpacity(0.5),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      country.fullName[0],
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontSize: 18),
                    ),
                  ),
                ),
                title: Text(
                  country.fullName,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
