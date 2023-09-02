import 'package:flutter/material.dart';

const Color _customColor = Color(0x00632DE0);
const List<Color> _colorTheme = [
  _customColor,
  Colors.blue,
  Colors.teal,
  Colors.yellow,
  Colors.orange,
  Colors.pink
];

class AppTheme {
  AppTheme({this.selectedColor = 0})
      : assert(selectedColor >= 0 && selectedColor < _colorTheme.length,
            'Colors must be between 0 and ${_colorTheme.length}');

  final int selectedColor;

  ThemeData theme() {
    // Usar material 3
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _colorTheme[selectedColor],
    );
  }
}
