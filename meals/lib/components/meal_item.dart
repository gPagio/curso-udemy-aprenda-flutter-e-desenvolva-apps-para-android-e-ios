import 'package:flutter/material.dart';

import 'package:meals/models/meal.dart' show Meal;

class MealItem extends StatelessWidget {
  final Meal meal;

  const MealItem(this.meal, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(child: Text(meal.title));
  }
}
