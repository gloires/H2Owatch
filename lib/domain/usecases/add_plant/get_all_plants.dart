import 'package:plant_tracker/domain/entities/plant_entity.dart';
import 'package:plant_tracker/domain/repositories/plant_repository.dart';

class GetAllPlants {
  final PlantRepository plantRepository;

  GetAllPlants({required this.plantRepository});

  Future<List<PlantEntity>> call() async {
    return await plantRepository.getAllPlants();
  }
}
