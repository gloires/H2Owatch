import 'package:plant_tracker/data/add_plant/models/plant_model.dart';
import 'package:plant_tracker/data/plant/plant_datasource.dart';
import 'package:plant_tracker/domain/entities/plant_entity.dart';
import 'package:plant_tracker/domain/repositories/plant_repository.dart';

class PlantRepositoryImpl implements PlantRepository {
  final PlantDatasource plantDatasource;

  PlantRepositoryImpl({
    required this.plantDatasource,
  });

  @override
  Future<List<PlantEntity>> getAllPlants() async {
    List<PlantModel> list = [];
    list = await plantDatasource.getAllPlants();

    return list;
  }
}
