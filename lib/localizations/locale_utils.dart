import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const String selectedLanguageCode = 'languageCode';

const String hebrew = 'עברית';
const String english = 'English';
const String he = 'he';
const String en = 'en';

Future<Locale> savePreferredLocale(String languageCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(selectedLanguageCode, languageCode);
  return _locale(languageCode);
}

Future<Locale> loadPreferredLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String languageCode = prefs.getString(selectedLanguageCode) ?? he;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case he:
      return const Locale(he, '');
    case en:
      return const Locale(en, '');
    default:
      return const Locale(he, '');
  }
}

AppLocalizations translate(BuildContext context) {
  return AppLocalizations.of(context)!;
}
