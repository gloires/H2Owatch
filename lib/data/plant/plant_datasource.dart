import 'package:plant_tracker/data/add_plant/models/plant_model.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class PlantDatasource {
  Future<List<PlantModel>> getAllPlants();
}

class PlantDatasourceImpl implements PlantDatasource {
  final Database database;

  PlantDatasourceImpl({required this.database});

  @override
  Future<List<PlantModel>> getAllPlants() async {
    List<PlantModel> result = [];

    List<Map> list = await database.rawQuery("""
        SELECT 
          name, type, image, date, 
          summer_period, summer_repetition,
          winter_period, winter_repetition
        FROM 
          plants 
        ORDER BY id ASC
          """);
    for (final item in list) {
      final invoice = PlantModel(
        id: item["id"] ?? 0,
        name: item["name"] ?? 0,
        type: item["type"] ?? 0,
        imagePath: item["image"] ?? 0,
        date: item["date"] ?? "",
        summerPeriod: item["summer_period"] ?? "",
        summerRepetition: item["summer_repetition"] ?? 0,
        winterPeriod: item["winter_period"] ?? 0,
        winterRepetition: item["winter_repetition"] ?? 0,
      );
      result.add(invoice);
    }

    return result;
  }
}

