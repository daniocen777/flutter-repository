import 'package:educationapp/core/usecases/usecases.dart';
import 'package:educationapp/core/utils/typedef.dart';
import 'package:educationapp/src/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

class SignUp extends UsecaseWithParams<void, SignUpParams> {
  SignUp(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<void> call(SignUpParams params) => _repository.signUp(
        email: params.email,
        fullname: params.fullName,
        password: params.password,
      );
}

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.email,
    required this.fullName,
    required this.password,
  });

  const SignUpParams.empty() : this(email: '', fullName: '', password: '');

  final String email;
  final String fullName;
  final String password;

  @override
  List<Object?> get props => [email, fullName, password];
}
