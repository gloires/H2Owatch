import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:plant_tracker/core/theme/theme.dart';
import 'package:plant_tracker/presentation/widgets/details_plant_item.dart';

class WaterPlantItem extends StatelessWidget {
  final String name;
  final String subtitle;

  const WaterPlantItem({
    Key? key,
    required this.name,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 120,
            margin: const EdgeInsets.only(left: 60),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
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
                    1: FixedColumnWidth(5),
                    2: FixedColumnWidth(65),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: <TableRow>[
                    TableRow(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              '(${subtitle.toUpperCase()})',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              children: [
                                DetailsPlantItem(
                                  icon: PhosphorIcons.drop,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                DetailsPlantItem(
                                  icon: PhosphorIcons.sunDim,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                DetailsPlantItem(
                                  icon: PhosphorIcons.thermometerHot,
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 75,
                          decoration: BoxDecoration(
                            color: kColorScheme.background,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 5,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              PhosphorIcons.drop,
                              size: 32,
                              color: kColorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 90,
            height: 90,
            margin: const EdgeInsets.symmetric(
              horizontal: 25.0,
              vertical: 14.0,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
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
    );
  }
}
