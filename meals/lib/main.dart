import 'package:flutter/material.dart';
import 'package:meals/screens/categories_meals_screen.dart'
    show CategoriesMealsScreen;
import 'package:meals/screens/categories_screen.dart' show CategoriesScreen;
import 'package:meals/theme/app_theme.dart' show AppTheme;
import 'package:meals/utils/app_routes.dart' show AppRoutes;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      routes: {
        AppRoutes.home: (ctx) => const CategoriesScreen(),
        AppRoutes.categoriesMeals: (ctx) => const CategoriesMealsScreen(),
      },
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: ThemeMode.system,
    );
  }
}
