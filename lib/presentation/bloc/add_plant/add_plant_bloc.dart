import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_tracker/domain/entities/plant_entity.dart';
import 'package:plant_tracker/domain/entities/plant_type_entity.dart';
import 'package:plant_tracker/domain/usecases/add_plant/get_plant_types.dart';
import 'package:plant_tracker/domain/usecases/add_plant/insert_plant.dart';
import 'package:plant_tracker/domain/usecases/plant/get_all_plants.dart';

part 'add_plant_event.dart';

part 'add_plant_state.dart';

class AddPlantBloc extends Bloc<AddPlantEvent, AddPlantState> {
  final GetPlantTypes getPlantTypes;
  final InsertPlant insertPlant;
  final GetAllPlants getAllPlants;

  PlantEntity plant = PlantEntity.empty();
  int id = -1;

  AddPlantBloc({
    required this.getPlantTypes,
    required this.insertPlant,
    required this.getAllPlants,
  }) : super(AddPlantInitialState()) {
    on<AddPlantPrepareEvent>(_onAddPlantPrepareEvent);
    on<AddPlantInsertEvent>(_onAddPlantInsertEvent);
    on<AddPlantLoadListEvent>(_onAddPlantLoadListEvent);
    on<AddPlantLoadTodayListEvent>(_onAddPlantLoadTodayListEvent);
  }

  FutureOr<void> _onAddPlantPrepareEvent(
    AddPlantPrepareEvent event,
    Emitter<AddPlantState> emit,
  ) async {
    final listPlantTypes = await getPlantTypes();
    emit(AddPlantPreparedState(
      plantTypes: listPlantTypes,
    ));
  }

  FutureOr<void> _onAddPlantInsertEvent(
    AddPlantInsertEvent event,
    Emitter<AddPlantState> emit,
  ) async {
    if(id == -1) {
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
    // emit(AddPlantLoadingListState());
    await _updateList(emit);
  }

  FutureOr<void> _onAddPlantLoadTodayListEvent(
      AddPlantLoadTodayListEvent event,
      Emitter<AddPlantState> emit,
      ) async {
    emit(AddPlantLoadingTodayListState());
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
}
