import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitialState()) {
    on<LoginEvent>((event, emit) {
      emit(state.copyWith(loading: true));
      print('Usuario => ${event.email}');
      print('Contraseña => ${event.password}');
      emit(state.copyWith(loading: false));
    });
    on<LoadingEvent>((event, emit) {
      emit(state.copyWith(loading: !state.loading));
    });
  }
}
