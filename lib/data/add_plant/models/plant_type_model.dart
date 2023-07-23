import 'package:plant_tracker/domain/entities/plant_type_entity.dart';

class PlantTypeModel extends PlantTypeEntity {
  const PlantTypeModel({
    required String id,
    required String name,
    required int summerPeriod,
    required int summerRepetition,
    required int winterPeriod,
    required int winterRepetition,
  }) : super(
          id: id,
          name: name,
          summerPeriod: summerPeriod,
          summerRepetition: summerRepetition,
          winterPeriod: winterPeriod,
          winterRepetition: winterRepetition,
        );

  factory PlantTypeModel.fromEntity(PlantTypeEntity type) {
    return PlantTypeModel(
      id: type.id,
      name: type.name,
      summerPeriod: type.summerPeriod,
      summerRepetition: type.summerRepetition,
      winterPeriod: type.winterPeriod,
      winterRepetition: type.winterRepetition,
    );
  }

  PlantTypeEntity toEntity() {
    return PlantTypeEntity(
      id: id,
      name: name,
      summerPeriod: summerPeriod,
      summerRepetition: summerRepetition,
      winterPeriod: winterPeriod,
      winterRepetition: winterRepetition,
    );
  }
}
