import 'package:creditsapp/app/domain/repositories/preferences_repository.dart';

import 'package:shared_preferences/shared_preferences.dart';

const darkModeKey = 'dark-mode';
const loguedKey = 'logued';

class PreferencesRepositoryImpl extends PreferencesRepository {
  final SharedPreferences _preferences;

  PreferencesRepositoryImpl(this._preferences);
  @override
  Future<void> darkMode(bool enabled) {
    return _preferences.setBool(darkModeKey, enabled);
  }

  @override
  bool get isDarkMode => _preferences.getBool(darkModeKey) ?? false;

  @override
  bool get isLogued => _preferences.getBool(loguedKey) ?? false;

  @override
  Future<void> isAuth(bool enabled) {
    return _preferences.setBool(loguedKey, enabled);
  }
}
