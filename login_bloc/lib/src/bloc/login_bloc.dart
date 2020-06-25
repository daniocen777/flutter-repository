import 'dart:async';

import 'package:login_bloc/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  // 1 => Dos controladores (para el email y password)
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // 3 => Recuperar datos del stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  // 5 => Unir los dos streams para validar el formulario
  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  // 2 => Getters y setters
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  // Obteniendo los últimos valores ingresados en los streams
  String get email => _emailController.value;
  String get password => _passwordController.value;

  // 4 => Cerrar
  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}
