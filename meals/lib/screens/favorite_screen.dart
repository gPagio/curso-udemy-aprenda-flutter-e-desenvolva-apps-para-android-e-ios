import 'package:flutter/material.dart';
import 'package:meals/components/meal_item.dart' show MealItem;
import 'package:meals/models/meal.dart' show Meal;

class FavoriteScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  const FavoriteScreen({super.key, required this.favoriteMeals});

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return const Center(
        child: Text("Nenhum favorito encontrado! Adicione alguns."),
      );
    }

    return ListView.builder(
      itemCount: favoriteMeals.length,
      itemBuilder: (context, index) {
        return MealItem(favoriteMeals[index]);
      },
    );
  }
}
