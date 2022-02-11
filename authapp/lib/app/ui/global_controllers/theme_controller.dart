import 'package:authapp/app/domain/repositories/preferences_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';

class ThemeController extends SimpleNotifier {
  late ThemeMode _themeMode;
  final _preferencesRepository = Get.i.find<PreferencesRepository>();

  ThemeController() {
    _themeMode =
        _preferencesRepository.isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  ThemeMode get themeMode => _themeMode;
  bool get isThemeDark => _themeMode == ThemeMode.dark;

  void toggle() {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
      _preferencesRepository.darkMode(true); // Guardando preferencias del tema
    } else {
      _themeMode = ThemeMode.light;
      _preferencesRepository.darkMode(false); // Guardando preferencias del tema
    }
    notify();
  }
}

// Crear el provider para llamarlo desde MyApp
final themeProvider =
    SimpleProvider((_) => ThemeController(), autoDispose: false);
