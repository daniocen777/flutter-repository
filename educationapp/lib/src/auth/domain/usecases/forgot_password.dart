import 'package:educationapp/core/usecases/usecases.dart';
import 'package:educationapp/core/utils/typedef.dart';
import 'package:educationapp/src/auth/domain/repositories/auth_repository.dart';

// UsecaseWithParams<lo que devuelve, tipó de dato que necesita>
class ForgotPassword extends UsecaseWithParams<void, String> {
  ForgotPassword(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<void> call(String params) => _repository.forgotPassword(params);
}
