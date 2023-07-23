import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:plant_tracker/core/theme/theme.dart';

class FrequencyPicker extends StatefulWidget {
  final bool autoSelect;
  final void Function() onTap;
  final String title;

  const FrequencyPicker({
    Key? key,
    required this.autoSelect,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  @override
  State<FrequencyPicker> createState() => _FrequencyPickerState();
}

class _FrequencyPickerState extends State<FrequencyPicker> {
  Color getColorText() {
    return widget.autoSelect ? kColorScheme.primary : kColorScheme.onBackground;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: widget.onTap,
      icon: Icon(
        PhosphorIcons.dropHalf,
        size: 20,
        color: getColorText(),
      ),
      label: Text(
        widget.title,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: getColorText(),
              fontSize: 13,
            ),
      ),
    );
  }
}
