import 'package:flutter/material.dart';

class FrequencyEventButton extends StatelessWidget {
  final String title;
  final int value;
  final int selectedValue;
  final ValueChanged<int?> onTap;

  const FrequencyEventButton({
    Key? key,
    required this.title,
    required this.value,
    required this.selectedValue,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == selectedValue;
    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.background,
          border: isSelected
              ? null
              : Border.all(color: Theme.of(context).colorScheme.onBackground),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 14,
                color: isSelected
                    ? Theme.of(context).colorScheme.background
                    : Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
