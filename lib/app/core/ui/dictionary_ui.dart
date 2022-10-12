import 'package:flutter/material.dart';
import 'package:dictionary/app/core/ui/constants_ui.dart';
import 'package:dictionary/app/core/ui/palette.dart';

class DictionaryUi {
  DictionaryUi._();

  static final ThemeData theme = ThemeData(
    primarySwatch: Palette.palette,
    primaryColor: ConstantsUi.kPrimaryColor,
    primaryColorDark: ConstantsUi.kPrimaryColorDark,
    fontFamily: 'Ubuntu',
    textTheme: const TextTheme().apply(
      bodyColor: ConstantsUi.kPrimaryColorDark,
    ),
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: ConstantsUi.kPrimaryColorDark,
        fontSize: 24,
      ),
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
              12,
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
    bottomSheetTheme: BottomSheetThemeData(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      backgroundColor: Colors.black.withOpacity(0),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
      primarySwatch: Palette.palette,
      primaryColor: ConstantsUi.kPrimaryColor,
      primaryColorDark: ConstantsUi.kPrimaryColorDark,
      fontFamily: 'Ubuntu',
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
                12,
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
      bottomSheetTheme: BottomSheetThemeData(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        backgroundColor: Colors.black.withOpacity(0),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>(
          (_) => ConstantsUi.kPrimaryColor,
        ),
      ));

  static const TextStyle textBold = TextStyle(fontWeight: FontWeight.bold);
}
