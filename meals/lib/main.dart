import 'package:flutter/material.dart';
import 'package:meals/screens/categories_meals_screen.dart'
    show CategoriesMealsScreen;
import 'package:meals/screens/meal_detail_screen.dart' show MealDetailScreen;
import 'package:meals/screens/settings_screen.dart' show SettingsScreen;
import 'package:meals/screens/tabs_screen.dart';
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
        AppRoutes.home: (ctx) => const TabsScreen(),
        AppRoutes.categoriesMeals: (ctx) => const CategoriesMealsScreen(),
        AppRoutes.mealDetail: (ctx) => const MealDetailScreen(),
        AppRoutes.settings: (ctx) => const SettingsScreen(),
      },
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: ThemeMode.system,
    );
  }
}
