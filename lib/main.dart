import 'package:flutter/material.dart';
import 'package:learny/pages/splash.dart'; // Your custom splash screen
import 'package:learny/services/theme_service.dart';
import 'package:learny/services/locale_service.dart'; // Added
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Added

// TODO: After running 'flutter gen-l10n', import the generated file:
// import 'package:learny/.dart_tool/flutter_gen/gen_l10n/app_localizations.dart';
// For now, we'll use placeholder delegates and locales.


Future<void> main() async { // Make main async
  WidgetsFlutterBinding.ensureInitialized(); // Ensures bindings are ready

  final themeService = await ThemeService.create();
  final localeService = await LocaleService.create(); // Added

  runApp(
    MultiProvider( // Changed to MultiProvider
      providers: [
        ChangeNotifierProvider<ThemeService>(create: (_) => themeService),
        ChangeNotifierProvider<LocaleService>(create: (_) => localeService), // Added
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final localeService = Provider.of<LocaleService>(context); // Added

    final ThemeData lightTheme = ThemeData(
      primarySwatch: Colors.purple,
      fontFamily: 'Afacad',
      brightness: Brightness.light,
    );

    final ThemeData darkTheme = ThemeData.dark().copyWith(
      primarySwatch: Colors.purple,
      fontFamily: 'Afacad',
      brightness: Brightness.dark,
      // Example: customize accent color for dark theme
      // accentColor: Colors.purpleAccent, // This property is deprecated, use colorScheme.secondary instead
      colorScheme: ColorScheme.dark(
        primary: Colors.purple,
        secondary: Colors.purpleAccent, // This is an example, adjust as needed
      ),
    );

    return MaterialApp(
      title: 'EduBoost',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeService.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      locale: localeService.locale, // Added
      // TODO: Replace with AppLocalizations.localizationsDelegates after 'flutter gen-l10n'
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // TODO: Replace with AppLocalizations.supportedLocales after 'flutter gen-l10n'
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('ar', ''), // Arabic, no country code
      ],
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // SplashScreen handles navigation after its animation
    );
  }
}
