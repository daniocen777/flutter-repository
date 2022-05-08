import 'package:creditsapp/app/domain/repositories/preferences_repository.dart';
import 'package:creditsapp/app/ui/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter_meedu/meedu.dart';

import 'package:flutter/services.dart';

class ThemeController extends SimpleNotifier {
  late ThemeMode _themeMode;
  final _preferencesRepository = Get.i.find<PreferencesRepository>();

  ThemeController() {
    _themeMode =
        _preferencesRepository.isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  ThemeMode get themeMode => _themeMode;
  bool get isThemeDark => _themeMode == ThemeMode.dark;

  ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      primaryColorLight: primaryLightColor,
      colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.light,
          primarySwatch: MaterialColor(primaryLightColor.value, swatch)),
      appBarTheme: const AppBarTheme(
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: primaryLightColor,
              systemNavigationBarIconBrightness: Brightness.light)),
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryLightColor.withOpacity(0.5))),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black12)),
      ),
    );
  }

  // Tema personalizado
  ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xff29434e),
      // Usar merge para que tome el tema asignado
      appBarTheme: const AppBarTheme(
          elevation: 0.0,
          backgroundColor: accentDarkColor,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: primaryDarkColor,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarIconBrightness: Brightness.dark)),
      primaryColorDark: primaryDarkColor,
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: primaryDarkColor),
      colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.dark,
          primarySwatch: MaterialColor(primaryDarkColor.value, swatch)),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryDarkColor)),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
      ),
    );
  }

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
