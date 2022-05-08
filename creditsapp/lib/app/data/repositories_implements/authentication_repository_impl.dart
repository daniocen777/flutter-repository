import 'package:shared_preferences/shared_preferences.dart';

import 'package:creditsapp/app/domain/repositories/authentication_repository.dart';

const loguedKey = 'isLogued';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  bool _isLogued = false;
  final SharedPreferences _preferences;

  AuthenticationRepositoryImpl(this._preferences);

  @override
  Future<bool> get isLogued async {
    final bool = _preferences.getBool(loguedKey);
    return bool ?? false;
  }

  @override
  Future<bool> signInWithUserAndPassword(String user, String password) async {
    if (user == 'danicode' && password == 'hawking777') {
      _isLogued = true;
      _preferences.setBool(loguedKey, true);
    } else {
      _isLogued = false;
    }

    return _isLogued;
  }
}
