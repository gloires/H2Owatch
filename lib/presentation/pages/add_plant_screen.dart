import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:plant_tracker/core/const/const.dart';
import 'package:plant_tracker/core/theme/theme.dart';
import 'package:plant_tracker/presentation/widgets/settings_for_new_item.dart';

class AddPlantScreen extends StatefulWidget {
  const AddPlantScreen({Key? key}) : super(key: key);

  @override
  State<AddPlantScreen> createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _latinNameController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _latinNameFocus = FocusNode();



  @override
  void initState() {
    super.initState();
    _nameFocus.addListener(() {
      setState(() {});
    });
    _latinNameFocus.addListener(() {
      setState(() {});
    });
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            PhosphorIcons.caretLeft,
            color: kColorScheme.background,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Додати нову квітку',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
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
                      labelStyle:
                          Theme.of(context).textTheme.titleSmall!.copyWith(
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
                  TextFormField(
                    controller: _latinNameController,
                    focusNode: _latinNameFocus,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      labelText: 'Вид',
                      labelStyle:
                          Theme.of(context).textTheme.titleSmall!.copyWith(
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
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const SettingsForNewItem(),
          ],
        ),
      ),
    );
  }
}
