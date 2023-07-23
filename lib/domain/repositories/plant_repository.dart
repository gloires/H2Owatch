import 'package:plant_tracker/domain/entities/plant_entity.dart';

abstract class PlantRepository {
  Future<List<PlantEntity>> getAllPlants();
}
