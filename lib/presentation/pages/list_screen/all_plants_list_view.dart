import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_tracker/domain/entities/plant_entity.dart';
import 'package:plant_tracker/presentation/bloc/add_plant/add_plant_bloc.dart';
import 'package:plant_tracker/presentation/widgets/list/all_plant_item.dart';

class AllPlantsListView extends StatelessWidget {
  const AllPlantsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPlantBloc, AddPlantState>(
      buildWhen: (previous, current) {
        return (current is AddPlantLoadedListState ||
            current is AddPlantEmptyState);
      },
      builder: (BuildContext context, state) {
        if (state is AddPlantLoadedListState) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: state.plants.length,
              itemBuilder: (context, itemPosition) {
                PlantEntity plant = state.plants[itemPosition];
                return AllPlantItem(
                  plant: plant,
                );
              },
            ),
          );
        }
        return const Center();
      },
    );
  }
}
