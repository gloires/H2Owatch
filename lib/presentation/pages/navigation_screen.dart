import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_tracker/presentation/bloc/add_plant/add_plant_bloc.dart';
import 'package:plant_tracker/presentation/pages/calendar_screen.dart';
import 'package:plant_tracker/presentation/pages/home_screen/home_screen.dart';
import 'package:plant_tracker/presentation/widgets/change_list_button.dart';
import 'package:plant_tracker/presentation/widgets/change_screen_button.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  Widget activeScreen = const HomeScreen();

  late final AddPlantBloc _addPlantBloc;

  bool _isHomeScreen = true;

  @override
  void initState() {
    super.initState();
    _addPlantBloc = BlocProvider.of<AddPlantBloc>(context);
  }

  void _setScreen() {
    setState(() {
      _isHomeScreen = !_isHomeScreen;
    });
 /*   if(_isHomeScreen) {
      _addPlantBloc.add(AddPlantLoadTodayListEvent());
    } else {
      _addPlantBloc.add(AddPlantLoadListEvent());
    }*/
  }

  void _setList() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    activeScreen = _isHomeScreen ? const HomeScreen() : const CalendarScreen();
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: (MediaQuery.of(context).size.height / 2) +
                  AppBar().preferredSize.height,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
            ),
            activeScreen,
            if (_isHomeScreen)
              ChangeListButton(
                onTap: _setList,
              ),
            ChangeScreenButton(
              onTap: _setScreen,
              isHomeScreen: _isHomeScreen,
            ),
          ],
        ),
      ),
    );
  }
}
