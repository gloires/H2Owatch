import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_tracker/domain/entities/plant_entity.dart';
import 'package:plant_tracker/domain/entities/plant_type_entity.dart';
import 'package:plant_tracker/domain/usecases/add_plant/get_plant.dart';
import 'package:plant_tracker/domain/usecases/add_plant/get_plant_types.dart';
import 'package:plant_tracker/domain/usecases/add_plant/insert_plant.dart';
import 'package:plant_tracker/domain/usecases/add_plant/get_all_plants.dart';

part 'add_plant_event.dart';

part 'add_plant_state.dart';

class AddPlantBloc extends Bloc<AddPlantEvent, AddPlantState> {
  final GetPlantTypes getPlantTypes;
  final InsertPlant insertPlant;
  final GetAllPlants getAllPlants;
  final GetPlant getPlant;

  PlantEntity plant = PlantEntity.empty();
  int id = -1;

  List<PlantTypeEntity> listPlantTypes = [];

  AddPlantBloc({
    required this.getPlantTypes,
    required this.insertPlant,
    required this.getAllPlants,
    required this.getPlant,
  }) : super(AddPlantInitialState()) {
    on<AddPlantPrepareEvent>(_onAddPlantPrepareEvent);
    on<AddPlantInsertEvent>(_onAddPlantInsertEvent);
    on<AddPlantLoadListEvent>(_onAddPlantLoadListEvent);
    on<AddPlantClearEvent>(_onAddPlantClearEvent);
  }

  FutureOr<void> _onAddPlantPrepareEvent(
    AddPlantPrepareEvent event,
    Emitter<AddPlantState> emit,
  ) async {
    emit(AddPlantStartState());
    id = event.plantID;
    listPlantTypes = await getPlantTypes();
    if (id != -1) {
      plant = await getPlant(plantID: event.plantID);
    }
    await _updatePrepare(emit);
  }

  FutureOr<void> _onAddPlantClearEvent(
    AddPlantClearEvent event,
    Emitter<AddPlantState> emit,
  ) async {
    emit(AddPlantClearState());
    id = -1;
    plant = PlantEntity.empty();
    listPlantTypes = await getPlantTypes();

    await _updatePrepare(emit);
  }

  FutureOr<void> _onAddPlantInsertEvent(
    AddPlantInsertEvent event,
    Emitter<AddPlantState> emit,
  ) async {
    if (id == -1) {
      insertPlant(
        name: event.name,
        type: event.type,
        imagePath: event.imagePath,
        date: event.date,
        summerPeriod: event.summerPeriod,
        summerRepetition: event.summerRepetition,
        winterPeriod: event.winterPeriod,
        winterRepetition: event.winterRepetition,
      );
    }
    await _updateList(emit);
    await Future.microtask(
      () => emit(AddPlantSavedState()),
    );
  }

  FutureOr<void> _onAddPlantLoadListEvent(
    AddPlantLoadListEvent event,
    Emitter<AddPlantState> emit,
  ) async {
    emit(AddPlantLoadingListState());
    await _updateList(emit);
  }

  Future<void> _updateList(Emitter<AddPlantState> emit) async {
    final plants = await getAllPlants();
    if (plants.isEmpty) {
      emit(AddPlantEmptyState());
      return;
    }
    emit(AddPlantLoadedListState(plants: plants));
  }

  Future<void> _updatePrepare(Emitter<AddPlantState> emit) async {
    emit(
      AddPlantPreparedState(
        plantTypes: listPlantTypes,
        plant: plant,
      ),
    );
  }
}
