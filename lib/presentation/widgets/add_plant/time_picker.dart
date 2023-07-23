import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:plant_tracker/core/theme/theme.dart';
import 'package:sprintf/sprintf.dart';

class TimePicker extends StatefulWidget {
  final bool autoSelect;

  const TimePicker({
    Key? key,
    required this.autoSelect,
  }) : super(key: key);

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  Time _time = Time(hour: 12, minute: 00);

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
    });
  }

  String formatTimeText(int time) {
    return sprintf("%02i", [time]);
  }

  void openTimePicker() {
    Navigator.of(context).push(
      showPicker(
        context: context,
        value: _time,
        onChange: onTimeChanged,
        is24HrFormat: true,
        showCancelButton: false,
        okText: 'Зберегти',
        cancelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
        okStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }

  Color getColorText() {
    return widget.autoSelect ? kColorScheme.primary : kColorScheme.onBackground;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: Icon(
        PhosphorIcons.alarm,
        size: 20,
        color: getColorText(),
      ),
      onPressed: widget.autoSelect ? openTimePicker : null,
      label: Text(
        '${formatTimeText(_time.hour)}:${formatTimeText(_time.minute)}',
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: getColorText(),
              fontSize: 13,
            ),
      ),
    );
  }
}
