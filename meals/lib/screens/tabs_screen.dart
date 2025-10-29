import 'package:flutter/material.dart';
import 'package:meals/components/main_drawer.dart' show MainDrawer;
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories_screen.dart' show CategoriesScreen;
import 'package:meals/screens/favorite_screen.dart' show FavoriteScreen;

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  const TabsScreen({super.key, required this.favoriteMeals});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  late List<Map<String, Object>> _screens;

  @override
  void initState() {
    super.initState();

    _screens = [
      {"title": "Lista de Categorias", "screen": const CategoriesScreen()},
      {
        "title": "Meus Favoritos",
        "screen": FavoriteScreen(favoriteMeals: widget.favoriteMeals),
      },
    ];
  }

  void _selectScreen(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[_selectedPageIndex]["title"] as String),
      ),
      drawer: const MainDrawer(),
      body: _screens[_selectedPageIndex]["screen"] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categorias",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favoritos"),
        ],
      ),
    );
  }
}
