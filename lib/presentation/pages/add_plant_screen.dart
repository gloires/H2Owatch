import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:plant_tracker/core/theme/theme.dart';
import 'package:plant_tracker/domain/entities/plant_entity.dart';
import 'package:plant_tracker/domain/entities/plant_type_entity.dart';
import 'package:plant_tracker/presentation/bloc/add_plant/add_plant_bloc.dart';
import 'package:plant_tracker/presentation/widgets/add_plant/save_button.dart';
import 'package:plant_tracker/presentation/widgets/add_plant/settings_for_new_item.dart';
import 'package:routemaster/routemaster.dart';

class AddPlantScreen extends StatefulWidget {
  final int plantID;

  const AddPlantScreen({
    Key? key,
    required this.plantID,
  }) : super(key: key);

  @override
  State<AddPlantScreen> createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  late final AddPlantBloc _addPlantBloc;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _latinNameController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _latinNameFocus = FocusNode();

  List<PlantTypeEntity> _plantTypeSuggestions = [];

  int _selectedSummerPeriodFrequency = -1;
  int _selectedSummerRepetitionFrequency = 1;

  String _frequencySummerText = 'Ніколи';

  int _selectedWinterPeriodFrequency = -1;
  int _selectedWinterRepetitionFrequency = 1;

  String _frequencyWinterText = 'Ніколи';

  int _typeSummerPeriod = -1;
  int _typeSummerRepetition = -1;
  int _typeWinterPeriod = -1;
  int _typeWinterRepetition = -1;

  File? image;

  PlantEntity _plant = PlantEntity.empty();

  Future<void> _pickImage() async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image ===> $e');
    }
  }

  void _changeSummerFrequencyText() {
    setState(() {
      if(_selectedSummerRepetitionFrequency == -1) {
        _selectedSummerRepetitionFrequency = 1;
      }
      switch (_selectedSummerPeriodFrequency) {
        case 0:
          _frequencySummerText =
              'Кожен $_selectedSummerRepetitionFrequency день';
          break;
        case 1:
          _frequencySummerText =
              'Кожен $_selectedSummerRepetitionFrequency тиждень';
          break;
        case 2:
          _frequencySummerText =
              'Кожен $_selectedSummerRepetitionFrequency місяць';
          break;
        default:
          _frequencySummerText = 'Ніколи';
      }
    });
  }

  void _changeWinterFrequencyText() {
    setState(() {
      if(_selectedWinterRepetitionFrequency == -1) {
        _selectedWinterRepetitionFrequency = 1;
      }
      switch (_selectedWinterPeriodFrequency) {
        case 0:
          _frequencyWinterText =
              'Кожен $_selectedWinterRepetitionFrequency день';
          break;
        case 1:
          _frequencyWinterText =
              'Кожен $_selectedWinterRepetitionFrequency тиждень';
          break;
        case 2:
          _frequencyWinterText =
              'Кожен $_selectedWinterRepetitionFrequency місяць';
          break;
        default:
          _frequencyWinterText = 'Ніколи';
      }
    });
  }

  ValueChanged<int?> _valueChangedSummerFrequencyHandler() {
    return (value) {
      return setState(() {
        _selectedSummerPeriodFrequency = value!;
        _changeSummerFrequencyText();
      });
    };
  }

  ValueChanged<int?> _valueChangedWinterFrequencyHandler() {
    return (value) {
      return setState(() {
        _selectedWinterPeriodFrequency = value!;
        _changeWinterFrequencyText();
      });
    };
  }

  void _addSummerRepetition() {
    setState(() {
      if(_selectedSummerRepetitionFrequency == -1) {
        _selectedSummerRepetitionFrequency = 1;
      }
      if (_selectedSummerRepetitionFrequency == 6 &&
          _selectedSummerPeriodFrequency == 0) {
        _selectedSummerRepetitionFrequency = 0;
        _selectedSummerPeriodFrequency = 1;
      }
      if (_selectedSummerRepetitionFrequency == 3 &&
          _selectedSummerPeriodFrequency == 1) {
        _selectedSummerRepetitionFrequency = 0;
        _selectedSummerPeriodFrequency = 2;
      }
      _selectedSummerRepetitionFrequency++;
      _changeSummerFrequencyText();
    });
  }

  void _addWinterRepetition() {
    setState(() {
      if(_selectedWinterRepetitionFrequency == -1) {
        _selectedWinterRepetitionFrequency = 1;
      }
      if (_selectedWinterRepetitionFrequency == 6 &&
          _selectedWinterPeriodFrequency == 0) {
        _selectedWinterRepetitionFrequency = 0;
        _selectedWinterPeriodFrequency = 1;
      }
      if (_selectedWinterRepetitionFrequency == 3 &&
          _selectedWinterPeriodFrequency == 1) {
        _selectedWinterRepetitionFrequency = 0;
        _selectedWinterPeriodFrequency = 2;
      }
      _selectedWinterRepetitionFrequency++;
      _changeWinterFrequencyText();
    });
  }

  void _removeSummerRepetition() {
    setState(() {
      if(_selectedSummerRepetitionFrequency == -1) {
        _selectedSummerRepetitionFrequency = 1;
      }
      if (_selectedSummerPeriodFrequency == 1 &&
          _selectedSummerRepetitionFrequency == 1) {
        _selectedSummerRepetitionFrequency = 7;
        _selectedSummerPeriodFrequency = 0;
      }
      if (_selectedSummerPeriodFrequency == 2 &&
          _selectedSummerRepetitionFrequency == 1) {
        _selectedSummerRepetitionFrequency = 4;
        _selectedSummerPeriodFrequency = 1;
      }
      if (_selectedSummerRepetitionFrequency >= 2) {
        _selectedSummerRepetitionFrequency--;
      }
      _changeSummerFrequencyText();
    });
  }

  void _removeWinterRepetition() {
    setState(() {
      if(_selectedWinterRepetitionFrequency == -1) {
        _selectedWinterRepetitionFrequency = 1;
      }
      if (_selectedWinterPeriodFrequency == 1 &&
          _selectedWinterRepetitionFrequency == 1) {
        _selectedWinterRepetitionFrequency = 7;
        _selectedWinterPeriodFrequency = 0;
      }
      if (_selectedWinterPeriodFrequency == 2 &&
          _selectedWinterRepetitionFrequency == 1) {
        _selectedWinterRepetitionFrequency = 4;
        _selectedWinterPeriodFrequency = 1;
      }
      if (_selectedWinterRepetitionFrequency >= 2) {
        _selectedWinterRepetitionFrequency--;
      }
      _changeWinterFrequencyText();
    });
  }

  @override
  void initState() {
    super.initState();
    _nameFocus.addListener(() {
      setState(() {});
    });
    _latinNameFocus.addListener(() {
      setState(() {});
    });

    _addPlantBloc = BlocProvider.of<AddPlantBloc>(context);
    _addPlantBloc.add(AddPlantPrepareEvent(plantID: widget.plantID));

    _nameController.text = '';
    _latinNameController.text = '';
    image = null;
    _selectedWinterRepetitionFrequency = -1;
    _selectedWinterPeriodFrequency = -1;
    _selectedSummerRepetitionFrequency = -1;
    _selectedSummerPeriodFrequency = -1;

    final state = _addPlantBloc.state;
    if (state is AddPlantPreparedState) {
      _plantTypeSuggestions = state.plantTypes;
      _plant = state.plant;
      if (!_plant.isEmpty()) {
        _nameController.text = _plant.name;
        _latinNameController.text = _plant.type;
        image = _plant.imagePath == '' ? null : File(_plant.imagePath);
        _selectedWinterRepetitionFrequency = _plant.winterRepetition;
        _selectedWinterPeriodFrequency = _plant.winterPeriod;
        _selectedSummerRepetitionFrequency = _plant.summerRepetition;
        _selectedSummerPeriodFrequency = _plant.summerPeriod;
        _changeSummerFrequencyText();
        _changeWinterFrequencyText();
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _latinNameController.dispose();
    _latinNameFocus.dispose();
    _nameFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddPlantBloc, AddPlantState>(
      listener: (context, state) {
        if (state is AddPlantPreparedState) {
          _plantTypeSuggestions = state.plantTypes;
          _plant = state.plant;
          if (!_plant.isEmpty()) {
            setState(() {
              _nameController.text = _plant.name;
              _latinNameController.text = _plant.type;
              image = _plant.imagePath == '' ? null : File(_plant.imagePath);
              _selectedWinterRepetitionFrequency = _plant.winterRepetition;
              _selectedWinterPeriodFrequency = _plant.winterPeriod;
              _selectedSummerRepetitionFrequency = _plant.summerRepetition;
              _selectedSummerPeriodFrequency = _plant.summerPeriod;
              _changeSummerFrequencyText();
              _changeWinterFrequencyText();
            });
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              PhosphorIcons.caretLeftBold,
              color: Colors.white,
            ),
            onPressed: () => Routemaster.of(context).pop(),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(40),
            ),
          ),
          title: const Text(
            'Додати нову квітку',
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: image == null
                        ? Container(
                            width: 130,
                            height: 130,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 30.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onBackground,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 5,
                                  offset: const Offset(1, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                '+',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontSize: 90),
                              ),
                            ),
                          )
                        : Container(
                            width: 130,
                            height: 130,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 30.0,
                              vertical: 30.0,
                            ),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(image!),
                                fit: BoxFit.cover,
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 5,
                                  offset: const Offset(1, 3),
                                ),
                              ],
                            ),
                          ),
                  ),
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _nameController,
                          focusNode: _nameFocus,
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            labelText: 'Ім\'я',
                            labelStyle: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: _nameFocus.hasFocus
                                      ? kColorScheme.primaryContainer
                                      : kColorScheme.onBackground,
                                  fontSize: 16,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: kColorScheme.onBackground,
                                width: 1.3,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: kColorScheme.primaryContainer,
                                width: 1.3,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          '(необов\'язково)',
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TypeAheadFormField(
                          hideOnEmpty: true,
                          minCharsForSuggestions: 3,
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: _latinNameController,
                            focusNode: _latinNameFocus,
                            style: Theme.of(context).textTheme.bodyMedium,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              labelText: 'Вид',
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: _latinNameFocus.hasFocus
                                        ? kColorScheme.primaryContainer
                                        : kColorScheme.onBackground,
                                    fontSize: 16,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: kColorScheme.onBackground,
                                  width: 1.3,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: kColorScheme.primaryContainer,
                                  width: 1.3,
                                ),
                              ),
                            ),
                          ),
                          suggestionsCallback: (pattern) async {
                            final List<PlantTypeEntity> namesLatin =
                                _plantTypeSuggestions
                                    .map((item) => item)
                                    .toList();
                            List<PlantTypeEntity> filteredList = namesLatin
                                .where(
                                  (element) =>
                                      element.name.toLowerCase().contains(
                                            pattern.toLowerCase(),
                                          ),
                                )
                                .toList();
                            return filteredList;
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              title: Text(suggestion.name),
                            );
                          },
                          suggestionsBoxDecoration:
                              const SuggestionsBoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          transitionBuilder:
                              (context, suggestionsBox, controller) {
                            return suggestionsBox;
                          },
                          onSuggestionSelected: (suggestion) {
                            _latinNameController.text = suggestion.name;
                            _typeSummerPeriod = suggestion.summerPeriod;
                            _typeSummerRepetition = suggestion.summerRepetition;
                            _typeWinterPeriod = suggestion.winterPeriod;
                            _typeWinterRepetition = suggestion.winterRepetition;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SettingsForNewItem(
                    selectedSummerPeriod: _selectedSummerPeriodFrequency,
                    selectedSummerRepetition:
                        _selectedSummerRepetitionFrequency,
                    addSummerRepetition: _addSummerRepetition,
                    removeSummerRepetition: _removeSummerRepetition,
                    onTapSummer: _valueChangedSummerFrequencyHandler(),
                    titleSummer: _frequencySummerText,
                    selectedWinterPeriod: _selectedWinterPeriodFrequency,
                    selectedWinterRepetition:
                        _selectedWinterRepetitionFrequency,
                    addWinterRepetition: _addWinterRepetition,
                    removeWinterRepetition: _removeWinterRepetition,
                    onTapWinter: _valueChangedWinterFrequencyHandler(),
                    titleWinter: _frequencyWinterText,
                  ),
                  const SizedBox(
                    height: 90,
                  ),
                ],
              ),
            ),
            SaveButton(
              addPlantBloc: _addPlantBloc,
              name: _nameController.text,
              type: _latinNameController.text,
              imagePath: image != null ? image!.path : '',
              summerPeriod: _selectedSummerPeriodFrequency == -1
                  ? _typeSummerPeriod
                  : _selectedSummerPeriodFrequency,
              summerRepetition: _selectedSummerRepetitionFrequency == -1
                  ? _typeSummerRepetition
                  : _selectedSummerRepetitionFrequency,
              winterPeriod: _selectedWinterPeriodFrequency == -1
                  ? _typeWinterPeriod
                  : _selectedWinterPeriodFrequency,
              winterRepetition: _selectedWinterRepetitionFrequency == -1
                  ? _typeWinterRepetition
                  : _selectedWinterRepetitionFrequency,
            ),
          ],
        ),
      ),
    );
  }
}
