import 'package:flutter/material.dart' show ThemeData, Colors, ListTileThemeData;

class AppTheme {
  ThemeData getTheme() {
    const seedColor = Colors.deepPurple;
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: seedColor,
      listTileTheme:  const ListTileThemeData(iconColor: seedColor)
    );
  }
}
