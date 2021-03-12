part of 'auth_bloc.dart';

@immutable
class AuthState {
  final LoginResponse loginResponse;
  final Usuario usuario;
  final String error;
  final bool cargando;
  final bool online;

  AuthState({
    this.loginResponse,
    this.usuario,
    this.error = '',
    this.cargando = false,
    this.online = false,
  });

  AuthState copyWith(
      {LoginResponse loginResponse,
      Usuario usuario,
      String error,
      bool cargando,
      bool online}) {
    return AuthState(
      loginResponse: loginResponse ?? this.loginResponse,
      usuario: usuario ?? this.usuario,
      error: error ?? this.error,
      cargando: cargando ?? this.cargando,
      online: online ?? this.online,
    );
  }
}
