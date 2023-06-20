import 'package:flutter/material.dart';
import 'package:plant_tracker/core/theme/colors.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: ThemeColors.green,
  brightness: Brightness.light,
  background: ThemeColors.white,
  primaryContainer: ThemeColors.green,
  primary: ThemeColors.black,
  onPrimaryContainer: ThemeColors.lightGreen,
  onPrimary: ThemeColors.yellow,
  onBackground: ThemeColors.lightGrey,
  outline: ThemeColors.lightGrey,
);

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: kColorScheme,
  appBarTheme: AppBarTheme(
    color: kColorScheme.primaryContainer,
    titleTextStyle: TextStyle(
      color: kColorScheme.background,
      fontWeight: FontWeight.w600,
      fontFamily: 'KyivType',
      fontSize: 20,
    ),
    centerTitle: true,
    shadowColor: Colors.black.withOpacity(0.25),
  ),
  textTheme: ThemeData().textTheme.copyWith(
        titleLarge: TextStyle(
          color: kColorScheme.onPrimary,
          fontWeight: FontWeight.w600,
          fontFamily: 'KyivType',
          fontSize: 40,
        ),
        titleMedium: TextStyle(
          color: kColorScheme.background,
          fontWeight: FontWeight.w400,
          fontFamily: 'KyivType',
          fontSize: 40,
        ),
        titleSmall: TextStyle(
          color: kColorScheme.onPrimary,
          fontWeight: FontWeight.w600,
          fontFamily: 'KyivType',
          fontSize: 20,
        ),
        labelMedium: TextStyle(
          color: kColorScheme.onPrimaryContainer,
          fontWeight: FontWeight.w400,
          fontFamily: 'KyivType',
          fontSize: 10,
        ),
        labelSmall: const TextStyle(
          fontWeight: FontWeight.w400,
          fontFamily: 'KyivType',
          fontSize: 8,
        ),
        bodySmall: TextStyle(
          color: kColorScheme.onBackground,
          fontWeight: FontWeight.w500,
          fontFamily: 'KyivType',
          fontSize: 11,
        ),
        bodyMedium: TextStyle(
          color: kColorScheme.primary,
          fontWeight: FontWeight.w500,
          fontFamily: 'KyivType',
          fontSize: 15,
        ),
      ),
);
