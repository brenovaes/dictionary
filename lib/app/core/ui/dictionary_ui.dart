import 'package:flutter/material.dart';
import 'package:dictionary/app/core/ui/constants_ui.dart';
import 'package:dictionary/app/core/ui/palette.dart';

class DictionaryUi {
  DictionaryUi._();

  static final ThemeData theme = ThemeData(
    primarySwatch: Palette.palette,
    primaryColor: ConstantsUi.kPrimaryColor,
    primaryColorDark: ConstantsUi.kPrimaryColorDark,
    fontFamily: 'MPLUSRounded1c',
    textTheme: const TextTheme().apply(
      bodyColor: ConstantsUi.kPrimaryColorDark,
    ),
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: ConstantsUi.kPrimaryColorDark),
      color: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: ConstantsUi.kPrimaryColorDark,
        fontSize: 24,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ConstantsUi.kPrimaryColor,
        textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              8,
            ),
          ),
        ),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: ConstantsUi.kPrimaryColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ConstantsUi.kPrimaryColor,
      foregroundColor: Colors.white,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Palette.palette,
    primaryColor: ConstantsUi.kPrimaryColor,
    primaryColorDark: ConstantsUi.kPrimaryColorDark,
    fontFamily: 'MPLUSRounded1c',
    textTheme: const TextTheme().apply(
      bodyColor: Colors.white,
    ),
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      color: ConstantsUi.kPrimaryColorDark,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 24,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      suffixIconColor: ConstantsUi.kPrimaryColorWhite,
      labelStyle: TextStyle(color: ConstantsUi.kPrimaryColorWhite),
      border: OutlineInputBorder(
          /* borderRadius: BorderRadius.circular(8), */
          ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ConstantsUi.kPrimaryColorWhite,
        ),
      ),
    ),
    scaffoldBackgroundColor: ConstantsUi.kPrimaryColorDark,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ConstantsUi.kPrimaryColor,
        textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              8,
            ),
          ),
        ),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: ConstantsUi.kPrimaryColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ConstantsUi.kPrimaryColor,
      foregroundColor: Colors.white,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color>(
        (_) => ConstantsUi.kPrimaryColor,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (_) => ConstantsUi.kPrimaryColorWhite,
        ),
      ),
    ),
  );

  static const TextStyle textBold = TextStyle(fontWeight: FontWeight.bold);
}
