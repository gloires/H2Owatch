import 'package:flutter/material.dart';
import 'package:plant_tracker/presentation/pages/add_plant_screen.dart';
import 'package:plant_tracker/presentation/widgets/water_plant_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void addButtonPress() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const AddPlantScreen(),
        ),
      );
    }

    return Positioned.fill(
      child: Stack(
        children: [
          Align(
            alignment: const Alignment(0.7, -0.9),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 2.4,
              child: Image.asset(
                'assets/images/grass.png',
              ),
            ),
          ),
          Align(
            alignment: const Alignment(-0.75, -0.2),
            child: Text(
              'Полити\nсьогодні',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: addButtonPress,
              child: Container(
                width: 60,
                height: 60,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 5,
                      offset: const Offset(1, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '+',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: (MediaQuery.of(context).size.height / 2) - 45,
              child: const SingleChildScrollView(
                child: Column(
                  children: [
                    WaterPlantItem(
                      name: 'Phillip',
                      subtitle: 'echeveria agavoides',
                    ),
                    WaterPlantItem(
                      name: 'Mary',
                      subtitle: 'haworthia floribunda',
                    ),
                    WaterPlantItem(
                      name: 'Dazzy',
                      subtitle: 'haworthia floribunda',
                    ),
                    WaterPlantItem(
                      name: 'Harold',
                      subtitle: 'haworthia floribunda',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
