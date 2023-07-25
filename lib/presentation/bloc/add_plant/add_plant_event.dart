part of 'add_plant_bloc.dart';

abstract class AddPlantEvent extends Equatable {
  const AddPlantEvent();

  @override
  List<Object> get props => [];
}

class AddPlantPrepareEvent extends AddPlantEvent {
  final int plantID;

  const AddPlantPrepareEvent({
    required this.plantID,
  });

  @override
  List<Object> get props => [
    plantID,
  ];
}

class AddPlantClearEvent extends AddPlantEvent {}

class AddPlantInsertEvent extends AddPlantEvent {
  final String name;
  final String type;
  final String imagePath;
  final int date;
  final int summerPeriod;
  final int summerRepetition;
  final int winterPeriod;
  final int winterRepetition;

  const AddPlantInsertEvent({
    required this.name,
    required this.type,
    required this.imagePath,
    required this.date,
    required this.summerPeriod,
    required this.summerRepetition,
    required this.winterPeriod,
    required this.winterRepetition,
  });

  @override
  List<Object> get props => [
        name,
        type,
        imagePath,
        date,
        summerPeriod,
        summerRepetition,
        winterPeriod,
        winterRepetition,
      ];
}

class AddPlantDeleteEvent extends AddPlantEvent {}

class AddPlantEditEvent extends AddPlantEvent {}

class AddPlantLoadListEvent extends AddPlantEvent {}