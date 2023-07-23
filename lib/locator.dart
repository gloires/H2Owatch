import 'package:get_it/get_it.dart';
import 'package:plant_tracker/data/add_plant/add_plant_sqlite_datasource.dart';
import 'package:plant_tracker/data/plant/plant_datasource.dart';
import 'package:plant_tracker/data/plant/plant_repository_impl.dart';
import 'package:plant_tracker/domain/repositories/plant_repository.dart';
import 'package:plant_tracker/domain/usecases/add_plant/insert_plant.dart';
import 'package:plant_tracker/domain/usecases/plant/get_all_plants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:plant_tracker/data/add_plant/add_plant_firebase_datasource.dart';
import 'package:plant_tracker/data/add_plant/add_plant_repository_impl.dart';
import 'package:plant_tracker/domain/repositories/add_plant_repository.dart';
import 'package:plant_tracker/domain/usecases/add_plant/get_plant_types.dart';
import 'package:plant_tracker/presentation/bloc/add_plant/add_plant_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///Bloc

  sl.registerLazySingleton(
    () => AddPlantBloc(
      getPlantTypes: sl(),
      insertPlant: sl(),
      getAllPlants: sl(),
    ),
  );

  ///Usecase

  sl.registerLazySingleton(
        () => GetAllPlants(
      plantRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetPlantTypes(
      addPlantRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
        () => InsertPlant(
      addPlantRepository: sl(),
    ),
  );

  ///Repository

  sl.registerLazySingleton<PlantRepository>(
        () => PlantRepositoryImpl(
      plantDatasource: sl(),
    ),
  );

  sl.registerLazySingleton<AddPlantRepository>(
    () => AddPlantRepositoryImpl(
      addPlantFirebaseDatasource: sl(),
      addPlantSqliteDatasource: sl(),
    ),
  );

  ///Datasource

  sl.registerLazySingleton<AddPlantFirebaseDatasource>(
    () => AddPlantFirebaseDatasourceImpl(),
  );
  sl.registerLazySingleton<AddPlantSqliteDatasource>(
    () => AddPlantSqliteDatasourceImpl(
      database: sl(),
    ),
  );
  sl.registerLazySingleton<PlantDatasource>(
        () => PlantDatasourceImpl(
      database: sl(),
    ),
  );

  ///External

  var databasesPath = await getDatabasesPath();
  String path = '$databasesPath/data.db';
  Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    await db.execute("""
      CREATE TABLE plants (
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        name TEXT, 
        type TEXT,
        image TEXT,
        date INTEGER,
        summer_period INTEGER,
        summer_repetition INTEGER,
        winter_period INTEGER,
        winter_repetition INTEGER
      )""");
  });
  sl.registerLazySingleton(() => database);
}
