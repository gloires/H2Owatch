import 'package:flutter/material.dart';
import 'package:plant_tracker/core/theme/theme.dart';
import 'package:plant_tracker/presentation/bloc/add_plant/add_plant_bloc.dart';
import 'package:routemaster/routemaster.dart';

class SaveButton extends StatelessWidget {
  final AddPlantBloc addPlantBloc;
  final String name;
  final String type;
  final String imagePath;
  final int summerPeriod;
  final int summerRepetition;
  final int winterPeriod;
  final int winterRepetition;

  const SaveButton({
    Key? key,
    required this.addPlantBloc,
    required this.name,
    required this.type,
    required this.imagePath,
    required this.summerRepetition,
    required this.summerPeriod,
    required this.winterRepetition,
    required this.winterPeriod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primary,
            fixedSize: const Size(230, 60),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            elevation: 5,
          ),
          onPressed: () {
            DateTime nowDate = DateTime.now();
            addPlantBloc.add(
              AddPlantInsertEvent(
                name: name,
                type: type,
                imagePath: imagePath,
                date: nowDate.millisecondsSinceEpoch ~/ 1000,
                summerPeriod: summerPeriod,
                summerRepetition: summerRepetition,
                winterRepetition: winterRepetition,
                winterPeriod: winterPeriod,
              ),
            );
            Routemaster.of(context).pop();
          },
          child: Text(
            'Зберегти',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ),
    );
  }
}
