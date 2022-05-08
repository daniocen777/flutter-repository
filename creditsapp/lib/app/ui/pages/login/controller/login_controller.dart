import 'package:flutter/widgets.dart' show GlobalKey, FormState;

import 'package:flutter_meedu/meedu.dart';
import 'package:creditsapp/app/domain/repositories/authentication_repository.dart';

class LoginController extends SimpleNotifier {
  String _user = '';
  String _password = '';
  final GlobalKey<FormState> formKey = GlobalKey();
  final _authenticationRepository = Get.i.find<AuthenticationRepository>();

  LoginController();

  void onUserChanged(String text) {
    _user = text;
  }

  void onPasswordChanged(String text) {
    _password = text;
  }

  Future<bool> submit() async {
    final signInResponse = await _authenticationRepository
        .signInWithUserAndPassword(_user, _password);

    if (signInResponse) {
      return true;
    }

    return false;
  }
}
