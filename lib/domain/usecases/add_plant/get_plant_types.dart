import 'package:plant_tracker/domain/entities/plant_type_entity.dart';
import 'package:plant_tracker/domain/repositories/add_plant_repository.dart';

class GetPlantTypes {
  final AddPlantRepository addPlantRepository;

  GetPlantTypes({required this.addPlantRepository});

  Future<List<PlantTypeEntity>> call() async {
    return await addPlantRepository.getPlantTypes();
  }
}
