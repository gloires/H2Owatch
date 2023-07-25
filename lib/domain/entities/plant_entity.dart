import 'package:equatable/equatable.dart';

class PlantEntity extends Equatable {
  final int id;
  final String name;
  final String type;
  final String imagePath;
  final int summerPeriod;
  final int summerRepetition;
  final int winterPeriod;
  final int winterRepetition;
  final DateTime date;

  const PlantEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.imagePath,
    required this.summerPeriod,
    required this.summerRepetition,
    required this.winterPeriod,
    required this.winterRepetition,
    required this.date,
  });

  factory PlantEntity.empty() {
    return PlantEntity(
      id: -1,
      name: '',
      date: DateTime.now(),
      type: '',
      imagePath: '',
      summerPeriod: 0,
      summerRepetition: 0,
      winterPeriod: 0,
      winterRepetition: 0,
    );
  }
  bool isEmpty() {
    return id < 0 || type.isEmpty;
  }

  @override
  List<Object?> get props => [
    id,
    name,
    type,
    imagePath,
    summerPeriod,
    summerRepetition,
    winterPeriod,
    winterRepetition,
    date,
  ];
}
