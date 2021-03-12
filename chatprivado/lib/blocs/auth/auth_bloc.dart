import 'dart:async';
import 'dart:convert';

import 'package:chatprivado/models/login_response.dart';
import 'package:chatprivado/models/usuario.dart';
import 'package:chatprivado/services/auth_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState());

  final _authService = new AuthService();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is OnLoginEvent) {
      yield* this.handleOnLoginEvent(event);
    } else if (event is OnRegisterEvent) {
      yield* this.handleOnRegisterEvent(event);
    } else if (event is OnRenovarTokenEvent) {
      yield* this.handleOnRenovarTokenEvent(event);
    } else if (event is OnLogoutEvent) {
      yield* this.handleOnLogoutEvent(event);
    }
  }

  Stream<AuthState> handleOnLogoutEvent(OnLogoutEvent event) async* {
    try {
      await _authService.logout();
      yield state.copyWith(online: false);
    } catch (e) {
      print('********************* ERROR *********************');
      print(e);
      print('******************************************');
    }
  }

  Stream<AuthState> handleOnRenovarTokenEvent(
      OnRenovarTokenEvent event) async* {
    try {
      yield state.copyWith(cargando: true);
      final LoginResponse loginResponse =
          await this._authService.estaLogueado();
      if (loginResponse.ok) {
        Map<String, dynamic> user = loginResponse.obj['usuario'];
        Usuario usuario = usuarioFromJson(json.encode(user));
        yield state.copyWith(
            loginResponse: loginResponse,
            usuario: usuario,
            cargando: false,
            online: true);
      } else {
        yield state.copyWith(error: loginResponse.msj, cargando: false);
      }
    } catch (e) {
      print('********************* ERROR *********************');
      print(e);
      yield state.copyWith(error: e, cargando: false);
      print('******************************************');
    }
  }

  Stream<AuthState> handleOnLoginEvent(OnLoginEvent event) async* {
    try {
      yield state.copyWith(cargando: true);
      final LoginResponse loginResponse =
          await this._authService.login(event.email, event.password);
      if (loginResponse.ok) {
        Map<String, dynamic> user = loginResponse.obj['usuario'];
        Usuario usuario = usuarioFromJson(json.encode(user));
        yield state.copyWith(
            loginResponse: loginResponse,
            usuario: usuario,
            cargando: false,
            online: true);
      } else {
        yield state.copyWith(error: loginResponse.msj, cargando: false);
      }
    } catch (e) {
      print('********************* ERROR *********************');
      print(e);
      yield state.copyWith(error: e, cargando: false);
      print('******************************************');
    }
  }

  Stream<AuthState> handleOnRegisterEvent(OnRegisterEvent event) async* {
    try {
      yield state.copyWith(cargando: true);
      final LoginResponse loginResponse = await this
          ._authService
          .registro(event.nombre, event.email, event.password);
      if (loginResponse.ok) {
        Map<String, dynamic> user = loginResponse.obj['usuario'];
        Usuario usuario = usuarioFromJson(json.encode(user));
        yield state.copyWith(
            loginResponse: loginResponse,
            usuario: usuario,
            cargando: false,
            online: true);
      } else {
        yield state.copyWith(error: loginResponse.msj, cargando: false);
      }
    } catch (e) {
      print('********************* ERROR *********************');
      print(e);
      yield state.copyWith(error: e, cargando: false);
      print('******************************************');
    }
  }
}
