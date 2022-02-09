import 'package:authapp/app/domain/repositories/authentication_repository.dart';
import 'package:authapp/app/domain/response/sign_in_response.dart';
import 'package:authapp/app/ui/global_controllers/session_controller.dart';
import 'package:flutter/widgets.dart' show GlobalKey, FormState;

import 'package:flutter_meedu/meedu.dart';

/* Solo extender de un SimpleNotifier, no de un StateNotifier como el registro */

class LoginController extends SimpleNotifier {
  /* Capturando el estado de sessionController */
  final SessionController _sessionController; // en el constructor
  String _email = '';
  String _password = '';
  final GlobalKey<FormState> formKey = GlobalKey();

  final _authenticationRepository = Get.i.find<AuthenticationRepository>();

  LoginController(this._sessionController);

  void onEmailChanged(String text) {
    _email = text;
  }

  void onPasswordChanged(String text) {
    _password = text;
  }

  Future<SignInResponse> submit() async {
    final signInResponse = await _authenticationRepository
        .signInWithEmailAndPassword(_email, _password);
    // Auth correcto
    if (signInResponse.error == null) {
      // Guardando los datos del usuarioo en sessionController
      _sessionController.setUser(signInResponse.user!);
    }
    return signInResponse;
  }
}
