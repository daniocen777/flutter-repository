import 'package:educationapp/core/usecases/usecases.dart';
import 'package:educationapp/core/utils/typedef.dart';
import 'package:educationapp/src/auth/domain/entities/user.dart';
import 'package:educationapp/src/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

class SignIn extends UsecaseWithParams<LocalUser, SignInParams> {
  SignIn(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<LocalUser> call(SignInParams params) =>
      _repository.signIn(email: params.email, password: params.password);
}

class SignInParams extends Equatable {
  const SignInParams({required this.email, required this.password});

  const SignInParams.empty() : this(email: '', password: '');

  final String email;
  final String password;

  @override
  List<String?> get props => [email, password];
}
