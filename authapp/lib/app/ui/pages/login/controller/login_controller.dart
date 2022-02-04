import 'package:authapp/app/domain/repositories/authentication_repository.dart';
import 'package:authapp/app/domain/response/sign_in_response.dart';
import 'package:flutter/widgets.dart' show GlobalKey, FormState;

import 'package:flutter_meedu/meedu.dart';

/* Solo extender de un SimpleNotifier, no de un StateNotifier como el registro */

class LoginController extends SimpleNotifier {
  String _email = '';
  String _password = '';
  final GlobalKey<FormState> formKey = GlobalKey();

  final _authenticationRepository = Get.i.find<AuthenticationRepository>();

  void onEmailChanged(String text) {
    _email = text;
  }

  void onPasswordChanged(String text) {
    _password = text;
  }

  Future<SignInResponse> submit() {
    return _authenticationRepository.signInWithEmailAndPassword(_email, _password);
  }
}
