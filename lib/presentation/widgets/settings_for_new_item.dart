import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:plant_tracker/core/const/const.dart';
import 'package:plant_tracker/core/theme/theme.dart';

class SettingsForNewItem extends StatefulWidget {
  const SettingsForNewItem({Key? key}) : super(key: key);

  @override
  State<SettingsForNewItem> createState() => _SettingsForNewItemState();
}

class _SettingsForNewItemState extends State<SettingsForNewItem> {
  bool _autoSelect = false;

  String _autoSettingsTitle = 'Автоматичне налаштування';
  String _autoSettingsHint = 'Увімкніть, щоби налаштувати самостійно';

  Time _time = Time(hour: 12, minute: 00);

  void _changeSettingsText() {
    setState(() {
      _autoSettingsTitle = 'Автоматичне налаштування';
      _autoSettingsHint = 'Увімкніть, щоби налаштувати самостійно';
      if (_autoSelect) {
        _autoSettingsTitle = 'Самостійне налаштування';
        _autoSettingsHint = 'Вимкніть, щоби налаштувати автоматично';
      }
    });
  }

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_autoSettingsTitle),
                  Text(
                    _autoSettingsHint,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Switch(
              value: _autoSelect,
              activeColor: kColorScheme.background,
              activeTrackColor: kColorScheme.primaryContainer,
              inactiveThumbColor: kColorScheme.background,
              inactiveTrackColor: kColorScheme.onBackground,
              onChanged: (bool value) {
                setState(() {
                  _autoSelect = value;
                  _changeSettingsText();
                });
              },
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                PhosphorIcons.calendarBlankBold,
                color: _autoSelect
                    ? kColorScheme.primary
                    : kColorScheme.onBackground,
              ),
            ),
            Wrap(
              children: dayOfWeek
                  .map(
                    (day) => Container(
                      margin: const EdgeInsets.only(
                        right: 15,
                      ),
                      child: Text(day),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
        Divider(
          color: kColorScheme.onBackground,
        ),
        Row(
          children: [
            Row(
              children: [
                Icon(
                  PhosphorIcons.alarm,
                  size: 20,
                  color: _autoSelect
                      ? kColorScheme.primary
                      : kColorScheme.onBackground,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      showPicker(
                        context: context,
                        value: _time,
                        onChange: onTimeChanged,
                        is24HrFormat: true,
                        showCancelButton: false,
                        okText: 'Зберегти',
                        cancelStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                        okStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                    );
                  },
                  child: Text(
                    '${_time.hour}:${_time.minute}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 35,
              child: VerticalDivider(
                color: kColorScheme.onBackground,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
