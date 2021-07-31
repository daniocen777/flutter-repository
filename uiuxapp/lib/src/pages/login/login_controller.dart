import 'package:flutter/widgets.dart';

import '../../data/models/user.dart';
import '../../data/providers/authentication_provider.dart';
import '../../data/repositories/authentication_repository.dart';
import '../../data/repositories_implementation/authentication_repository_impl.dart';

class LoginController extends ChangeNotifier {
  String _email = '';
  String _password = '';
  final AuthenticationRepository _repository =
      AuthenticationRepositoryImpl(AuthenticationProvider());

  void onEmailChanged(String text) {
    _email = text;
  }

  void onPasswordChanged(String text) {
    _password = text;
  }

  Future<User?> submit() async {
    /* Llamar a la API, BD o firebase */
    return await _repository.login(this._email, this._password);
  }
}
