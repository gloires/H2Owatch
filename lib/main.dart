import 'package:flutter/material.dart';
import 'package:plant_tracker/core/theme/theme.dart';
import 'package:plant_tracker/presentation/pages/navigation_screen.dart';

void main() {
  runApp(const PlantApp());
}

class PlantApp extends StatelessWidget {
  const PlantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const NavigationScreen(),
    );
  }
}
