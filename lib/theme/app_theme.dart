import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFD4A574), // Vintage gold/brown
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: const Color(0xFFFEF9E7), // Cream/light yellow
      cardColor: const Color(0xFFFFF8E1), // Light cream
      
      // Typography
      fontFamily: 'Georgia',
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Georgia',
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Color(0xFF5D4037), // Dark brown
        ),
        displayMedium: TextStyle(
          fontFamily: 'Georgia',
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Color(0xFF5D4037),
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Georgia',
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Color(0xFF5D4037),
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          color: Color(0xFF4E342E),
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
          color: Color(0xFF4E342E),
        ),
      ),
      
      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFD4A574), // Vintage gold
        foregroundColor: Color(0xFF3E2723), // Dark brown
        elevation: 2,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Georgia',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFF3E2723),
        ),
      ),
      
      // Card Theme
      cardTheme: CardThemeData(
        color: const Color(0xFFFFF8E1),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            color: Color(0xFFD4A574),
            width: 1,
          ),
        ),
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD4A574),
          foregroundColor: const Color(0xFF3E2723),
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Georgia',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF8D6E63),
          textStyle: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFFFF8E1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFD4A574)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFD4A574)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF8D6E63), width: 2),
        ),
        labelStyle: const TextStyle(
          fontFamily: 'Roboto',
          color: Color(0xFF8D6E63),
        ),
        hintStyle: const TextStyle(
          fontFamily: 'Roboto',
          color: Color(0xFFA1887F),
        ),
      ),
      
      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFFD4A574),
        foregroundColor: Color(0xFF3E2723),
        elevation: 4,
      ),
      
      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: Color(0xFFD4A574),
        thickness: 1,
      ),
    );
  }
}
