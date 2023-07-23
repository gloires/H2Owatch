import 'package:flutter/material.dart';
import 'package:plant_tracker/core/theme/theme.dart';

class DetailsPlantItem extends StatelessWidget {
  final IconData icon;

  const DetailsPlantItem({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(
        border: Border.all(color: kColorScheme.onPrimaryContainer),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Icon(
        icon,
        size: 15,
        color: kColorScheme.onPrimaryContainer,
      ),
    );
  }
}
