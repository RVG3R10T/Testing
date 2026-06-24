import 'package:flutter/material.dart';

class AppTheme {
  static const primaryColor = Color(0xFF6366F1);
  static const secondaryColor = Color(0xFF10B981);
  static const accentColor = Color(0xFFF59E0B);
  static const errorColor = Color(0xFFEF4444);
  
  static const darkBg = Color(0xFF1F2937);
  static const darkSurface = Color(0xFF111827);
  static const lightBg = Color(0xFFFAFAFA);
  static const lightSurface = Color(0xFFFFFFFF);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: lightBg,
      appBarTheme: const AppBarTheme(
        backgroundColor: lightSurface,
        elevation: 1,
        centerTitle: true,
      ),
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        error: errorColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF3F4F6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: darkSurface,
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBg,
        elevation: 1,
        centerTitle: true,
      ),
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        error: errorColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
