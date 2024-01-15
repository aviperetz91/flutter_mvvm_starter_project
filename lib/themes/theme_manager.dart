import 'package:flutter/material.dart';
import 'package:flutter_mvvm/themes/app_themes.dart';

enum ThemeType { light, dark }

class ThemeManager with ChangeNotifier {
  ThemeType _themeType = ThemeType.light;

  ThemeType get themeType => _themeType;

  ThemeData get theme =>
      themeType == ThemeType.light ? AppThemes.lightTheme : AppThemes.darkTheme;

  void changeTheme(String type) {
    if (type == ThemeType.dark.name) {
      _themeType = ThemeType.dark;
    } else {
      _themeType = ThemeType.light;
    }
    notifyListeners();
  }
}
