import 'package:plant_tracker/domain/repositories/add_plant_repository.dart';

class InsertPlant {
  final AddPlantRepository addPlantRepository;

  InsertPlant({
    required this.addPlantRepository,
  });

  Future<int> call({
    required String name,
    required String type,
    required String imagePath,
    required int date,
    required int summerPeriod,
    required int summerRepetition,
    required int winterPeriod,
    required int winterRepetition,
  }) async {
    return await addPlantRepository.insert(
      name,
      type,
      imagePath,
      date,
      summerPeriod,
      summerRepetition,
      winterPeriod,
      winterRepetition,
    );
  }
}
