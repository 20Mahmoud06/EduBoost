import 'package:flutter/material.dart';
import 'package:learny/pages/splash.dart'; // Your custom splash screen
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

Future<void> main() async { // Make main async
  WidgetsFlutterBinding.ensureInitialized(); // Ensures bindings are ready

  // Attempt to initialize SharedPreferences here.
  // This makes it more likely to be ready when SplashScreen needs it.
  try {
    await SharedPreferences.getInstance();
    print("SharedPreferences initialized successfully in main.");
  } catch (e) {
    print("Error initializing SharedPreferences in main: $e");
    // In a real app, you might want to handle this critical failure,
    // perhaps by showing a static error screen instead of runApp.
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduBoost',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Afacad',
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // SplashScreen handles navigation after its animation
    );
  }
}
