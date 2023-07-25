part of 'add_plant_bloc.dart';

abstract class AddPlantState extends Equatable {
  const AddPlantState();

  @override
  List<Object> get props => [];
}

class AddPlantInitialState extends AddPlantState {}

class AddPlantStartState extends AddPlantState {}

class AddPlantClearState extends AddPlantState {}

class AddPlantPreparedState extends AddPlantState {
  final List<PlantTypeEntity> plantTypes;
  final PlantEntity plant;

  const AddPlantPreparedState({
    required this.plantTypes,
    required this.plant,
  });
}

class AddPlantSavedState extends AddPlantState {}

class AddPlantLoadingListState extends AddPlantState {}

class AddPlantEmptyState extends AddPlantState {}

class AddPlantLoadedListState extends AddPlantState {
  final List<PlantEntity> plants;

  const AddPlantLoadedListState({
    required this.plants,
  });

  @override
  List<Object> get props => [plants];
}
