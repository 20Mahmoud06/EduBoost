import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService extends ChangeNotifier {
  static const _themeModeKey = 'themeMode';
  late SharedPreferences _prefs;
  bool _isDarkMode = false;

  ThemeService._privateConstructor(); // Private constructor

  static Future<ThemeService> create() async {
    final service = ThemeService._privateConstructor();
    await service._init();
    return service;
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    _isDarkMode = _prefs.getBool(_themeModeKey) ?? false;
  }

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _prefs.setBool(_themeModeKey, _isDarkMode);
    notifyListeners();
  }
}
