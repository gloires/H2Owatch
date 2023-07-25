import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:plant_tracker/presentation/pages/list_screen/all_plants_list_view.dart';
import 'package:routemaster/routemaster.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void addButtonPress() {
      Routemaster.of(context).push('add_plant');
    }

    return Stack(
      children: [
        Scaffold(
          appBar: PlantAppBar(
            height: 86,
            onPressed: addButtonPress,
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: AllPlantsListView(),
            ),
          ),
        ),
      ],
    );
  }
}

class PlantAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final void Function() onPressed;

  const PlantAppBar({
    Key? key,
    required this.height,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            AppBar(
              toolbarHeight: 56,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              title: const Text(
                'Усі квіти',
              ),
              leading: IconButton(
                icon: const Icon(
                  PhosphorIcons.caretLeftBold,
                  color: Colors.white,
                ),
                onPressed: () => Routemaster.of(context).pop(),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            onTap: onPressed,
            child: Container(
              width: 60,
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
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
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
