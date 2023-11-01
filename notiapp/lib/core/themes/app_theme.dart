import 'package:flutter/material.dart' show ThemeData, Color;

class AppTheme {
  ThemeData getTheme() =>
      ThemeData(useMaterial3: true, colorSchemeSeed: const Color(0xff2862f5));
}
