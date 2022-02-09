import 'package:authapp/app/domain/response/sign_up_response.dart';
import 'package:authapp/app/ui/global_controllers/session_controller.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_meedu/meedu.dart';

import 'package:authapp/app/domain/inputs/sign_up.dart';
import 'package:authapp/app/domain/repositories/sign_up_repository.dart';
import 'package:authapp/app/ui/pages/register/controller/register_state.dart';

/* Usando StateNorifier (similar a Bloc) */
// ver: https://flutter.meedu.app/docs/5.x.x/state-management/state-notifier
class RegisterController extends StateNotifier<RegisterState> {
  // Estado de la sesión
  final SessionController _sessionController;
  RegisterController(this._sessionController)
      : super(RegisterState.initialState);

  // injectando
  final _signUpRepository = Get.i.find<SignUpRepository>();
  /* Para validar el formulario */
  final GlobalKey<FormState> formKey = GlobalKey();

  Future<SignUpResponse> submit() async {
    final signUpResponse = await _signUpRepository.register(SignUpData(
        name: state.name,
        lastname: state.lastname,
        email: state.email,
        password: state.password));

    if (signUpResponse.error == null) {
      _sessionController.setUser(signUpResponse.user!);
    }

    return signUpResponse;
  }

  void onNameChanged(String text) {
    /* Creando una copia del estado original */
    state = state.copyWith(name: text);
  }

  void onlastNameChanged(String text) {
    /* Creando una copia del estado original */
    state = state.copyWith(lastname: text);
  }

  void onEmailChanged(String text) {
    /* Creando una copia del estado original */
    state = state.copyWith(email: text);
  }

  void onPasswordChanged(String text) {
    /* Creando una copia del estado original */
    state = state.copyWith(password: text);
  }

  void onVerifyPasswordChanged(String text) {
    /* Creando una copia del estado original */
    state = state.copyWith(verifyPassword: text);
  }
}
