import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plant_tracker/domain/entities/plant_entity.dart';
import 'package:routemaster/routemaster.dart';

class AllPlantItem extends StatelessWidget {
  final PlantEntity plant;

  const AllPlantItem({
    Key? key,
    required this.plant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hasImage = plant.imagePath != '';

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          Routemaster.of(context).push('edit_plant/${plant.id}');
        },
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 120,
              margin: const EdgeInsets.only(left: 60, right: 40),
              decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .colorScheme
                    .primaryContainer,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(-5, 5),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 30.0, left: 65.0),
                child: Center(
                  child: Table(
                    border: null,
                    columnWidths: const <int, TableColumnWidth>{
                      0: FlexColumnWidth(),
                      1: FixedColumnWidth(15),
                      2: FixedColumnWidth(35),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: <TableRow>[
                      TableRow(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                plant.name,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleSmall,
                              ),
                              Text(
                                '(${plant.type.toUpperCase()})',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .labelMedium,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            hasImage
                ? Container(
              width: 90,
              height: 90,
              margin: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 14.0,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(File(plant.imagePath)),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 7,
                    offset: const Offset(-2, 2),
                  ),
                ],
              ),
            )
                : Container(
              width: 90,
              height: 90,
              margin: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 14.0,
              ),
              decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .colorScheme
                    .primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 7,
                    offset: const Offset(-2, 2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
