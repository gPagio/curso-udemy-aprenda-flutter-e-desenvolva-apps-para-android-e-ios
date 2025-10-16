import 'package:flutter/material.dart';
import 'package:meals/models/category.dart' show Category;

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [category.color.withValues(alpha: 0.5), category.color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Text(category.title),
    );
  }
}
