import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learny/services/theme_service.dart';
import 'package:learny/services/locale_service.dart'; // Added

// TODO: After running 'flutter gen-l10n', import the generated file:
// import 'package:learny/.dart_tool/flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final localeService = Provider.of<LocaleService>(context); // Added
    // final appLocalizations = AppLocalizations.of(context)!; // TODO: Uncomment after 'flutter gen-l10n'

    return Scaffold(
      appBar: AppBar(
        // TODO: Replace with appLocalizations.settingsPageTitle
        title: Text(localeService.locale.languageCode == 'ar' ? 'الإعدادات' : 'Settings', style: const TextStyle(fontFamily: 'Afacad', color: Colors.white)),
        backgroundColor: const Color(0xFFBF33FF), // Your app's primary color
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            // TODO: Replace with appLocalizations.darkModeLabel
            title: Text(localeService.locale.languageCode == 'ar' ? 'الوضع الداكن' : 'Dark Mode', style: const TextStyle(fontFamily: 'Afacad', fontSize: 18)),
            secondary: Icon(themeService.isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined),
            value: themeService.isDarkMode,
            onChanged: (bool value) {
              themeService.toggleTheme();
            },
          ),
          const Divider(),
          ListTile(
            // TODO: Replace with appLocalizations.languageLabel
            title: Text(localeService.locale.languageCode == 'ar' ? 'اللغة' : 'Language', style: const TextStyle(fontFamily: 'Afacad', fontSize: 18)),
            trailing: DropdownButton<Locale>( // Changed to DropdownButton<Locale>
              value: localeService.locale, // Use locale from LocaleService
              icon: const Icon(Icons.arrow_drop_down),
              elevation: 16,
              style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontFamily: 'Afacad', fontSize: 16),
              underline: Container(
                height: 2,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onChanged: (Locale? newValue) {
                if (newValue != null) {
                  localeService.setLocale(newValue);
                }
              },
              // TODO: Update to use AppLocalizations.supportedLocales and display names from actual localizations after 'flutter gen-l10n'
              items: [
                const Locale('en', ''),
                const Locale('ar', '')
              ].map<DropdownMenuItem<Locale>>((Locale locale) {
                return DropdownMenuItem<Locale>(
                  value: locale,
                  // TODO: Replace with appLocalizations.englishLanguage / appLocalizations.arabicLanguage or a more robust solution
                  child: Text(locale.languageCode == 'ar' ? 'العربية (Arabic)' : 'English'),
                );
              }).toList(),
            ),
          ),
          // Add more settings items here
        ],
      ),
    );
  }
}
