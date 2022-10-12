import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor palette =
      MaterialColor(_palettePrimaryValue, <int, Color>{
    50: Color(0xFFE5E5EC),
    100: Color(0xFFBFBFD0),
    200: Color(0xFF9494B0),
    300: Color(0xFF696990),
    400: Color(0xFF494979),
    500: Color(_palettePrimaryValue),
    600: Color(0xFF242459),
    700: Color(0xFF1F1F4F),
    800: Color(0xFF191945),
    900: Color(0xFF0F0F33),
  });
  static const int _palettePrimaryValue = 0xFF292961;

  static const MaterialColor paletteAccent =
      MaterialColor(_paletteAccentValue, <int, Color>{
    100: Color(0xFF7070FF),
    200: Color(_paletteAccentValue),
    400: Color(0xFF0A0AFF),
    700: Color(0xFF0000F0),
  });
  static const int _paletteAccentValue = 0xFF3D3DFF;
}
