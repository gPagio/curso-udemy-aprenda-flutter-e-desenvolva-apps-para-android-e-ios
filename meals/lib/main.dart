// lib/main.dart
import 'package:flutter/material.dart';
import 'package:meals/screens/categories_screen.dart' show CategoriesScreen;
import 'package:meals/theme/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: ThemeMode.system,
      home: const CategoriesScreen(),
    );
  }
}
