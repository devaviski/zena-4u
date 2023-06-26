import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zena_foru/screens/home_screen.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((fn) {
    runApp(const ProviderScope(child: App()));
  });
}

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.latoTextTheme().copyWith(
          bodyMedium: const TextStyle(
            color: Colors.white,
          ),
          bodyLarge: const TextStyle(
            color: Colors.white,
          ),
          titleLarge: const TextStyle(
            color: Colors.white,
          ),
          titleMedium: const TextStyle(
            color: Colors.white,
          ),
          titleSmall: const TextStyle(
            color: Colors.white,
          ),
          headlineLarge: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
