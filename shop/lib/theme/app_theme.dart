import 'package:flutter/material.dart';

class AppTheme {
  // Cores
  static const primaryColor = Colors.purple;
  static const accentColor = Colors.deepOrange;

  // Fonte Padrão
  static const defaultFontFamily = 'Lato';

  // Tema Claro
  static ThemeData lightTheme() {
    final lightThemeColorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      secondary: accentColor,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: lightThemeColorScheme,
      fontFamily: defaultFontFamily,
    );
  }
}
