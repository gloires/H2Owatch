import 'package:equatable/equatable.dart';

class PlantTypeEntity extends Equatable {
  final String id;
  final String name;
  final int summerPeriod;
  final int winterPeriod;
  final int summerRepetition;
  final int winterRepetition;

  const PlantTypeEntity({
    required this.id,
    required this.name,
    required this.summerPeriod,
    required this.winterPeriod,
    required this.winterRepetition,
    required this.summerRepetition,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        summerPeriod,
        winterPeriod,
        winterRepetition,
        summerRepetition,
      ];
}
