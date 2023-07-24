import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';
import 'package:plant_tracker/locator.dart';
import 'package:plant_tracker/presentation/bloc/add_plant/add_plant_bloc.dart';
import 'package:plant_tracker/presentation/pages/add_plant_screen.dart';
import 'package:plant_tracker/presentation/pages/navigation_screen.dart';

final routes = RoutemasterDelegate(
  routesBuilder: (BuildContext context) {
    final addPlantBloc = sl<AddPlantBloc>();

    return RouteMap(
      routes: {
        '/': (route) => MaterialPage(
              child: BlocProvider.value(
                value: addPlantBloc..add(AddPlantLoadListEvent()),
                child: const NavigationScreen(),
              ),
            ),
        '/add_plant': (route) => MaterialPage(
              child: BlocProvider.value(
                value: addPlantBloc,
                child: const AddPlantScreen(),
              ),
            ),
      },
    );
  },
);
