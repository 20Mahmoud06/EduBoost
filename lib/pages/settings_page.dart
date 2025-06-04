import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;
  String _selectedLanguage = 'English'; // Default language

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(fontFamily: 'Afacad', color: Colors.white)),
        backgroundColor: const Color(0xFFBF33FF), // Your app's primary color
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title: const Text('Dark Mode', style: TextStyle(fontFamily: 'Afacad', fontSize: 18)),
            secondary: Icon(_isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined),
            value: _isDarkMode,
            onChanged: (bool value) {
              setState(() {
                _isDarkMode = value;
                // TODO: Implement actual dark mode theme switching logic
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Dark Mode ${value ? "Enabled" : "Disabled"} (UI not implemented)')),
                );
              });
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Language', style: TextStyle(fontFamily: 'Afacad', fontSize: 18)),
            trailing: DropdownButton<String>(
              value: _selectedLanguage,
              icon: const Icon(Icons.arrow_drop_down),
              elevation: 16,
              style: const TextStyle(color: Color(0xFFBF33FF), fontFamily: 'Afacad', fontSize: 16),
              underline: Container(
                height: 2,
                color: const Color(0xFFBF33FF),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                  // TODO: Implement actual language switching logic (e.g., using localization packages)
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Language changed to $newValue (Localization not implemented)')),
                  );
                });
              },
              items: <String>['English', 'العربية (Arabic)']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
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
