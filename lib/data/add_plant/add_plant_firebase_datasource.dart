import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plant_tracker/core/const/const.dart';
import 'package:plant_tracker/data/add_plant/models/plant_type_model.dart';

abstract class AddPlantFirebaseDatasource {
  Future<List<PlantTypeModel>> getPlantTypes();
}

class AddPlantFirebaseDatasourceImpl implements AddPlantFirebaseDatasource {
  @override
  Future<List<PlantTypeModel>> getPlantTypes() async {
    final response = await http.get(urlLatinNames);
    final Map<String, dynamic> listData = await json.decode(response.body);
    final List<PlantTypeModel> loadedItems = [];
    for (final item in listData.entries) {
      loadedItems.add(
        PlantTypeModel(
          id: item.key,
          name: item.value['name'],
          summerPeriod: item.value['summer_period'],
          summerRepetition: item.value['summer_repetition'],
          winterPeriod: item.value['winter_period'],
          winterRepetition: item.value['winter_repetition'],
        ),
      );
    }
    return loadedItems;
  }
}
