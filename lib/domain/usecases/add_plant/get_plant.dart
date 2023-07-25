import 'package:plant_tracker/domain/entities/plant_entity.dart';
import 'package:plant_tracker/domain/repositories/add_plant_repository.dart';

class GetPlant {
  final AddPlantRepository addPlantRepository;

  GetPlant({required this.addPlantRepository});

  Future<PlantEntity> call({required int plantID}) async {
    return await addPlantRepository.getPlant(plantID);
  }
}
