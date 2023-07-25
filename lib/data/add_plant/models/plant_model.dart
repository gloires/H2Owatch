import 'package:plant_tracker/domain/entities/plant_entity.dart';

class PlantModel extends PlantEntity {
  PlantModel({
    required int id,
    required String name,
    required String type,
    required String imagePath,
    required int summerPeriod,
    required int summerRepetition,
    required int winterPeriod,
    required int winterRepetition,
    required int date,
  }) : super(
          id: id,
          name: name,
          type: type,
          imagePath: imagePath,
          summerPeriod: summerPeriod,
          summerRepetition: summerRepetition,
          winterPeriod: winterPeriod,
          winterRepetition: winterRepetition,
          date: DateTime.fromMillisecondsSinceEpoch(date * 1000),
        );

  factory PlantModel.fromEntity(PlantEntity plant) {
    return PlantModel(
      id: plant.id,
      name: plant.name,
      type: plant.type,
      imagePath: plant.imagePath,
      summerPeriod: plant.summerPeriod,
      summerRepetition: plant.summerRepetition,
      winterPeriod: plant.winterPeriod,
      winterRepetition: plant.winterRepetition,
      date: plant.date.millisecondsSinceEpoch ~/ 1000,
    );
  }

  PlantModel toEntity() {
    return PlantModel(
      id: id,
      name: name,
      type: type,
      imagePath: imagePath,
      summerPeriod: summerPeriod,
      summerRepetition: summerRepetition,
      winterPeriod: winterPeriod,
      winterRepetition: winterRepetition,
      date: date.millisecondsSinceEpoch ~/ 1000,
    );
  }
}
