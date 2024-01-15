import 'package:flutter/material.dart';
import 'package:flutter_mvvm/localizations/locale_utils.dart';

class LocaleManager extends ChangeNotifier {
  Locale _locale = const Locale(he);

  Locale get locale => _locale;
  bool get isRtl => _locale.languageCode == he;

  LocaleManager() {
    loadPreferredLocale().then((locale) {
      _locale = locale;
      notifyListeners();
    });
  }

  setLocale(String languageCode) {
    savePreferredLocale(languageCode).then((locale) {
      _locale = locale;
      notifyListeners();
    });
  }
}
