import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:plant_tracker/core/const/const.dart';
import 'package:plant_tracker/core/theme/theme.dart';
import 'package:plant_tracker/presentation/widgets/add_plant/frequency_event_button.dart';
import 'package:plant_tracker/presentation/widgets/add_plant/frequency_picker.dart';
import 'package:plant_tracker/presentation/widgets/add_plant/time_picker.dart';

class SettingsForNewItem extends StatefulWidget {
  final int selectedSummerPeriod;
  final int selectedSummerRepetition;
  final ValueChanged<int?> onTapSummer;
  final void Function() addSummerRepetition;
  final void Function() removeSummerRepetition;
  final String titleSummer;

  final int selectedWinterPeriod;
  final int selectedWinterRepetition;
  final ValueChanged<int?> onTapWinter;
  final void Function() addWinterRepetition;
  final void Function() removeWinterRepetition;
  final String titleWinter;

  const SettingsForNewItem({
    Key? key,
    required this.selectedSummerPeriod,
    required this.selectedSummerRepetition,
    required this.onTapSummer,
    required this.addSummerRepetition,
    required this.removeSummerRepetition,
    required this.titleSummer,
    required this.selectedWinterPeriod,
    required this.selectedWinterRepetition,
    required this.onTapWinter,
    required this.addWinterRepetition,
    required this.removeWinterRepetition,
    required this.titleWinter,
  }) : super(key: key);

  @override
  State<SettingsForNewItem> createState() => _SettingsForNewItemState();
}

class _SettingsForNewItemState extends State<SettingsForNewItem> {
  bool _autoSelect = false;
  bool _summer = true;

  String _autoSettingsTitle = 'Автоматичне налаштування';
  String _autoSettingsHint = 'Увімкніть, щоби налаштувати самостійно';

  bool _showDetailedFrequency = false;

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
              onPressed: () {
                setState(() {
                  _summer = !_summer;
                });
              },
              icon: Icon(
                !_autoSelect
                    ? PhosphorIcons.calendarBlankBold
                    : _summer
                        ? PhosphorIcons.sun
                        : PhosphorIcons.snowflake,
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
                      child: Text(
                        day,
                        style: TextStyle(
                          color: _autoSelect
                              ? kColorScheme.primary
                              : kColorScheme.onBackground,
                        ),
                      ),
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
            const Expanded(child: SizedBox.shrink()),
            TimePicker(autoSelect: _autoSelect),
            SizedBox(
              height: 35,
              child: VerticalDivider(
                color: kColorScheme.onBackground,
              ),
            ),
            FrequencyPicker(
              autoSelect: _autoSelect,
              title: _summer ? widget.titleSummer : widget.titleWinter,
              onTap: () {
                setState(() {
                  _showDetailedFrequency = !_showDetailedFrequency;
                });
              },
            ),
            const Expanded(child: SizedBox.shrink()),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        if (_showDetailedFrequency && _autoSelect)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FrequencyEventButton(
                      title: 'День',
                      value: 0,
                      selectedValue: _summer
                          ? widget.selectedSummerPeriod
                          : widget.selectedWinterPeriod,
                      onTap: _summer ? widget.onTapSummer : widget.onTapWinter,
                    ),
                    FrequencyEventButton(
                      title: 'Тиждень',
                      value: 1,
                      selectedValue: _summer
                          ? widget.selectedSummerPeriod
                          : widget.selectedWinterPeriod,
                      onTap: _summer ? widget.onTapSummer : widget.onTapWinter,
                    ),
                    FrequencyEventButton(
                      title: 'Місяць',
                      value: 2,
                      selectedValue: _summer
                          ? widget.selectedSummerPeriod
                          : widget.selectedWinterPeriod,
                      onTap: _summer ? widget.onTapSummer : widget.onTapWinter,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Оберіть частоту повторення:',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 13),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: _summer
                            ? widget.removeSummerRepetition
                            : widget.removeWinterRepetition,
                        icon: const Icon(PhosphorIcons.minusBold),
                      ),
                      Text(
                        _summer
                            ? widget.selectedSummerRepetition != -1
                                ? widget.selectedSummerRepetition.toString()
                                : '1'
                            : widget.selectedWinterRepetition != -1
                                ? widget.selectedWinterRepetition.toString()
                                : '1',
                      ),
                      IconButton(
                        onPressed: _summer
                            ? widget.addSummerRepetition
                            : widget.addWinterRepetition,
                        icon: const Icon(PhosphorIcons.plusBold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }
}
