import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleService extends ChangeNotifier {
  static const _localeKey = 'locale_code';
  late SharedPreferences _prefs;
  Locale _locale = const Locale('en'); // Default to English

  LocaleService._privateConstructor(); // Private constructor

  static Future<LocaleService> create() async {
    final service = LocaleService._privateConstructor();
    await service._init();
    return service;
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    final languageCode = _prefs.getString(_localeKey);
    if (languageCode != null) {
      _locale = Locale(languageCode);
    }
  }

  Locale get locale => _locale;

  void setLocale(Locale newLocale) {
    if (_locale == newLocale) return; // No change

    _locale = newLocale;
    _prefs.setString(_localeKey, newLocale.languageCode);
    notifyListeners();
  }
}
