import 'package:flutter/material.dart';
import 'package:meals/models/category.dart' show Category;

class CategoriesMealsScreen extends StatelessWidget {
  final Category category;

  const CategoriesMealsScreen(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Receitas')),
      body: Center(child: Text('Receitas por Categoria ${category.id}')),
    );
  }
}
