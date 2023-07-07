import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;
import 'package:zena_foru/screens/splash.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((fn) {
    runApp(const ProviderScope(child: App()));
  });
  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
          bodySmall: const TextStyle(
            color: Colors.white70,
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
      home: const SplashScreen(),
    );
  }
}
