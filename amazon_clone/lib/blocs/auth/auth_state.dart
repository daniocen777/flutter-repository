part of 'auth_bloc.dart';

@immutable
class AuthState extends Equatable {
  final bool loading;

  const AuthState({this.loading = false});

  AuthState copyWith({bool? loading}) {
    return AuthState(loading: loading ?? this.loading);
  }

  @override
  List<Object> get props => [loading];
}

class AuthInitialState extends AuthState {
  const AuthInitialState() : super(loading: false);
}
