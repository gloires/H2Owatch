import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';
import 'package:plant_tracker/bloc_observer.dart';
import 'package:plant_tracker/core/routing/routes.dart';
import 'package:plant_tracker/core/theme/theme.dart';
import 'package:plant_tracker/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  Bloc.observer = SimpleBlocObserver();
  runApp(const PlantApp());
}

class PlantApp extends StatelessWidget {
  const PlantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: theme,
      routerDelegate: routes,
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
