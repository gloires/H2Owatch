import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ChangeScreenButton extends StatelessWidget {
  final void Function() onTap;
  final String identifier;

  const ChangeScreenButton({
    Key? key,
    required this.onTap,
    required this.identifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
               identifier == 'home' ? PhosphorIcons.calendarBlank : PhosphorIcons.flower,
                size: 20,
                color: Theme.of(context).colorScheme.background,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
