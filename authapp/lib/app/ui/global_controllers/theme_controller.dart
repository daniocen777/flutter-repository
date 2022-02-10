import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';

class ThemeController extends SimpleNotifier {
  ThemeMode _themeMode = ThemeMode.light; // tema por defecto

  ThemeMode get themeMode => _themeMode;
  bool get isThemeDark => _themeMode == ThemeMode.dark;

  void toggle() {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    notify();
  }
}

// Crear el provider para llamarlo desde MyApp
final themeProvider =
    SimpleProvider((_) => ThemeController(), autoDispose: false);
