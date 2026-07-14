import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: const Color(0xFF0F4C81), // أزرق طبي احترافي
      scaffoldBackgroundColor: const Color(0xFFF4F7FA), // لون خلفية مريح
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0F4C81),
        primary: const Color(0xFF0F4C81),
        secondary: const Color(0xFF00B4D8),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0F4C81),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0F4C81),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}