import 'package:flutter/material.dart';
import 'package:flutter_mvvm/themes/app_colors.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColors.light,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColors.dark,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.dark,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.dark,
      ),
      labelLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.dark,
      ),
      labelMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.dark,
      ),
      labelSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.dark,
      ),
      titleLarge: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 24,
        color: AppColors.dark,
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 22,
        color: AppColors.dark,
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: AppColors.dark,
      ),
    ),
    colorScheme: const ColorScheme.light().copyWith(
      primary: AppColors.dark,
      onPrimary: AppColors.light,
      primaryContainer: AppColors.light,
      secondary: AppColors.grey,
      onSecondary: AppColors.light,
      secondaryContainer: Colors.white,
      tertiary: AppColors.lightGrey,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.light,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.dark,
      unselectedItemColor: AppColors.grey,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      unselectedLabelStyle:
          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
    ),
    appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: AppColors.light,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.dark, size: 20),
      titleTextStyle: const TextStyle(
        color: AppColors.dark,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      shape: const Border(
        bottom: BorderSide(width: 0.1),
      ),
    ),
    tabBarTheme: const TabBarTheme().copyWith(
      indicator: const UnderlineTabIndicator(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        borderSide: BorderSide(
          color: AppColors.dark,
          width: 3,
        ),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.dark,
    primaryColor: AppColors.light,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColors.light,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.light,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.light,
      ),
      labelLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.light,
      ),
      labelMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.light,
      ),
      labelSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.light,
      ),
      titleLarge: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 24,
        color: AppColors.light,
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 22,
        color: AppColors.light,
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: AppColors.light,
      ),
    ),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: AppColors.light,
      onPrimary: AppColors.dark,
      primaryContainer: AppColors.dark,
      secondary: AppColors.lightGrey,
      onSecondary: AppColors.dark,
      secondaryContainer: AppColors.deepDark,
      tertiary: AppColors.lightGrey,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.deepDark,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.light,
      unselectedItemColor: AppColors.grey,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
      unselectedLabelStyle:
          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
    ),
    appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: AppColors.deepDark,
      elevation: 0,
      titleTextStyle: const TextStyle(
        color: AppColors.light,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      shape: const Border(
        bottom: BorderSide(width: 0.1),
      ),
    ),
    tabBarTheme: const TabBarTheme().copyWith(
      indicator: const UnderlineTabIndicator(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        borderSide: BorderSide(
          color: AppColors.light,
          width: 3,
        ),
      ),
    ),
  );
}
