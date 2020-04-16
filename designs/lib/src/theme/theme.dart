import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  bool _darkTheme = false;
  bool _customTheme = false;
  ThemeData _currentTheme;

  ThemeChanger(int theme) {
    switch (theme) {
      case 1: // Light
        _darkTheme = false;
        _customTheme = false;
        _currentTheme = ThemeData.light();
        break;
      case 2: // Dark
        _darkTheme = true;
        _customTheme = false;
        _currentTheme =
            ThemeData.dark().copyWith(accentColor: Colors.pinkAccent);
        break;
      case 3: // Personalizado
        _darkTheme = false;
        _customTheme = true;
        break;
      default:
        _darkTheme = false;
        _customTheme = false;
        _currentTheme = ThemeData.light();
    }
  }

  bool get darkTheme => this._darkTheme;
  bool get customTheme => this._customTheme;
  ThemeData get currentTheme => this._currentTheme;

  set darkTheme(bool valor) {
    _customTheme = false;
    _darkTheme = valor;
    if (valor) {
      _currentTheme = ThemeData.dark().copyWith(accentColor: Colors.pinkAccent);
    } else {
      _currentTheme = ThemeData.light();
    }
    notifyListeners();
  }

  set customTheme(bool valor) {
    _darkTheme = false;
    _customTheme = valor;
    if (valor) {
      _currentTheme = ThemeData.dark().copyWith(
          primaryColorLight: Colors.white,
          accentColor: Color(0xff48A0EB),
          scaffoldBackgroundColor: Color(0xff16202B),
          textTheme: TextTheme(body1: TextStyle(color: Colors.white)));
    } else {
      _currentTheme = ThemeData.dark();
    }
    notifyListeners();
  }
}
