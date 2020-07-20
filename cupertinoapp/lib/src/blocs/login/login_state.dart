import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool fetching; // Animación de cargando
  // Intentos fallidos para loguearse (3)
  final int intents;

  LoginState({this.fetching = false, this.intents = 0});

  @override
  List<Object> get props => [fetching, intents];

  /*  Creando una copia de LoginState */
  LoginState copyWith({bool fetching, int intents}) {
    return LoginState(
        fetching: fetching ?? this.fetching, intents: intents ?? this.intents);
  }
}
