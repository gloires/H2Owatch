import 'package:flutter/material.dart';
import 'package:plant_tracker/presentation/pages/calendar_screen.dart';
import 'package:plant_tracker/presentation/pages/home_screen.dart';
import 'package:plant_tracker/presentation/widgets/change_screen_button.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  Widget activeScreen = const HomeScreen();

  var identifier = 'home';

  void _setScreen() {
    if(identifier == 'home') {
      setState(() {
        identifier = 'calendar';
        activeScreen = const CalendarScreen();
      });
    } else {
      setState(() {
        identifier = 'home';
        activeScreen = const HomeScreen();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
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
            ChangeScreenButton(
              onTap: _setScreen,
              identifier: identifier,
            ),
            activeScreen,
          ],
        ),
      ),
    );
  }
}
