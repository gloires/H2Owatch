import 'package:plant_tracker/data/add_plant/models/plant_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class AddPlantSqliteDatasource {
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

  Future<void> edit(PlantModel plant, int id);

  Future<void> delete(int plantID);
}

class AddPlantSqliteDatasourceImpl implements AddPlantSqliteDatasource {
  final Database database;

  AddPlantSqliteDatasourceImpl({required this.database});

  @override
  Future<void> delete(int plantID) async {
    await database.rawQuery(
      """
      DELETE FROM
        plants
      WHERE
        id = ?
      """,
      [plantID],
    );
  }

  @override
  Future<void> edit(PlantModel plant, int id) async {
    await database.rawUpdate('''
        UPDATE
          plants
        SET
          name = ?,
          type = ?,
          image = ?,
          date = ?,
          summer_period = ?,
          summer_repetition = ?,
          winter_period = ?,
          winter_repetition = ?
        WHERE
          id = ?
      ''', [
      plant.name,
      plant.type,
      plant.imagePath,
      plant.date,
      plant.summerPeriod,
      plant.summerRepetition,
      plant.winterPeriod,
      plant.winterRepetition,
      id,
    ]);
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
    int winterRepetition,
  ) async {
    return await database.rawInsert(
      '''
          INSERT INTO plants(name, type, image, date, summer_period, summer_repetition, winter_period, winter_repetition) 
          VALUES(?, ?, ?, ?, ?, ?, ?, ?)
          ''',
      [
        name,
        type,
        imagePath,
        date,
        summerPeriod,
        summerRepetition,
        winterPeriod,
        winterRepetition,
      ],
    );
  }
}
