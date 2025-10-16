import 'package:flutter/material.dart';

class AppTheme {
  // Cores base
  static const Color seedColor = Colors.pink;
  static const Color primaryColor = Colors.pink;
  static const Color accentColor = Colors.amber;
  static const Color scaffoldBackground = Color.fromRGBO(255, 254, 229, 1);

  // Fontes
  static const String primaryFont = 'Raleway';
  static const String secondaryFont = 'RobotoCondensed';

  // Tema claro
  static ThemeData lightTheme() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      primary: primaryColor,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackground,
      fontFamily: primaryFont,

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        surfaceTintColor: colorScheme.primary,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: secondaryFont,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: colorScheme.onPrimary,
        ),
      ),

      // Text Theme
      textTheme: ThemeData.light().textTheme.copyWith(
        headlineLarge: const TextStyle(fontSize: 20, fontFamily: secondaryFont),
      ),
    );
  }

  // Tema escuro
  static ThemeData darkTheme() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: Colors.grey[900],
      fontFamily: primaryFont,

      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        surfaceTintColor: colorScheme.primary,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: secondaryFont,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: colorScheme.onPrimary,
        ),
      ),

      textTheme: ThemeData.dark().textTheme.copyWith(
        headlineLarge: const TextStyle(fontSize: 20, fontFamily: secondaryFont),
      ),
    );
  }
}
