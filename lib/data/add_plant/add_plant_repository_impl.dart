import 'package:plant_tracker/data/add_plant/add_plant_firebase_datasource.dart';
import 'package:plant_tracker/data/add_plant/add_plant_sqlite_datasource.dart';
import 'package:plant_tracker/data/add_plant/models/plant_model.dart';
import 'package:plant_tracker/data/add_plant/models/plant_type_model.dart';
import 'package:plant_tracker/domain/entities/plant_entity.dart';
import 'package:plant_tracker/domain/entities/plant_type_entity.dart';
import 'package:plant_tracker/domain/repositories/add_plant_repository.dart';

class AddPlantRepositoryImpl implements AddPlantRepository {
  final AddPlantFirebaseDatasource addPlantFirebaseDatasource;
  final AddPlantSqliteDatasource addPlantSqliteDatasource;

  AddPlantRepositoryImpl({
    required this.addPlantFirebaseDatasource,
    required this.addPlantSqliteDatasource,
  });

  @override
  Future<List<PlantTypeEntity>> getPlantTypes() async {
    List<PlantTypeModel> list = [];
    list = await addPlantFirebaseDatasource.getPlantTypes();

    return list.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> delete(int plantID) async {
    await addPlantSqliteDatasource.delete(plantID);
  }

  @override
  Future<void> edit(PlantEntity plant, int id) async {
    await addPlantSqliteDatasource.edit(PlantModel.fromEntity(plant), id);
  }

  @override
  Future<int> insert(
      String name,
      String type,
      String imagePath,
      int date,
      int summerPeriod,
      int summerRepetition,
      int winterPeriod,
      int winterRepetition) async {
    return await addPlantSqliteDatasource.insert(
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

  @override
  Future<PlantEntity> getPlant(int plantID) async{
    final p = await addPlantSqliteDatasource.getPlant(plantID);
    return p.toEntity();
  }
}
