import 'package:flutter/material.dart';
import 'package:meals/components/main_drawer.dart' show MainDrawer;

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Configurações")),
      drawer: const MainDrawer(),
      body: Center(child: Text("Configurações")),
    );
  }
}
