import 'package:plant_tracker/domain/entities/plant_entity.dart';
import 'package:plant_tracker/domain/entities/plant_type_entity.dart';

abstract class AddPlantRepository {
  Future<List<PlantTypeEntity>> getPlantTypes();

  Future<PlantEntity> getPlant(int plantID);

  Future<int> insert(
    String name,
    String type,
    String imagePath,
    int date,
    int summerPeriod,
    int summerRepetition,
    int winterPeriod,
    int winterRepetition,
  );

  Future<void> edit(PlantEntity plant, int id);

  Future<void> delete(int plantID);
}
