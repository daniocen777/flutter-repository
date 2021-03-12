part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class OnLoginEvent extends AuthEvent {
  final String email;
  final String password;

  OnLoginEvent(this.email, this.password);
}

class OnRegisterEvent extends AuthEvent {
  final String nombre;
  final String email;
  final String password;

  OnRegisterEvent(this.nombre, this.email, this.password);
}

class OnRenovarTokenEvent extends AuthEvent {}

class OnLogoutEvent extends AuthEvent {}
