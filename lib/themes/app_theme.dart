import 'package:flutter/material.dart';

class AppTheme {
  static const Color background = Color(0xFFFAF7F2);
  static const Color primary = Color(0xFF8C6A5D);
  static const Color darkText = Color(0xFF5E4636);
  static const Color lightText = Color(0xFF7A6B5D);

  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      fontFamily: 'Arial',

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          minimumSize: const Size(220, 55),
        ),
      ),
    );
  }
}