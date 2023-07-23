import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_month_calendar/model/calendar_event.dart';
import 'package:one_month_calendar/one_month_calendar.dart';
import 'package:plant_tracker/presentation/bloc/add_plant/add_plant_bloc.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var day = 1;
    var week = 7;
    var month = 30;

    List<CalendarEvent> list = [];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: BlocBuilder<AddPlantBloc, AddPlantState>(
          buildWhen: (previous, current) {
            return (current is AddPlantLoadedListState ||
                current is AddPlantEmptyState);
          },
          builder: (BuildContext context, state) {
            if (state is AddPlantLoadedListState) {
              var now = DateTime.now();
              bool summer = true;
              if (now.month >= 4 && now.month <= 9) {
                summer = true;
              } else {
                summer = false;
              }

              int getRecurrence(int period, int repetition) {
                if (period == 0) {
                  return day * repetition;
                } else if (period == 1) {
                  return week * repetition;
                } else if (period == 2) {
                  return month * repetition;
                }
                return 0;
              }

              list = state.plants
                  .map(
                    (p) => CalendarEvent(
                  p.name,
                  description: p.type,
                  imagePath: p.imagePath,
                  startTime: p.date,
                  endTime:
                  DateTime.utc(p.date.year + 1, p.date.month, p.date.day),
                  recurrence: summer
                      ? getRecurrence(p.summerPeriod, p.summerRepetition)
                      : getRecurrence(p.winterPeriod, p.winterRepetition),
                ),
              )
                  .toList();
              return Calendar(
                eventsList: list,
                isExpandable: true,
                selectedColor:
                Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
                selectedTodayColor: Theme.of(context).colorScheme.onPrimary,
                todayColor: Theme.of(context).colorScheme.onPrimary,
                eventColor: Theme.of(context).colorScheme.onPrimary,
                defaultDayColor: Theme.of(context).colorScheme.background,
                defaultOutOfMonthDayColor:
                Theme.of(context).colorScheme.onPrimaryContainer,
                locale: 'uk_UK',
                isExpanded: true,
                datePickerType: DatePickerType.date,
                dayOfWeekStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              );
            }
            return Calendar(
              eventsList: const [],
              isExpandable: true,
              selectedColor:
              Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
              selectedTodayColor: Theme.of(context).colorScheme.onPrimary,
              todayColor: Theme.of(context).colorScheme.onPrimary,
              eventColor: Theme.of(context).colorScheme.onPrimary,
              defaultDayColor: Theme.of(context).colorScheme.background,
              defaultOutOfMonthDayColor:
              Theme.of(context).colorScheme.onPrimaryContainer,
              locale: 'uk_UK',
              isExpanded: true,
              datePickerType: DatePickerType.date,
              dayOfWeekStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 20,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            );
          },
        ),
      ),
    );
  }
}