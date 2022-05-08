abstract class PreferencesRepository {
  bool get isDarkMode;

  bool get isLogued;

  Future<void> darkMode(bool enabled);

  Future<void> isAuth(bool enabled);
}
