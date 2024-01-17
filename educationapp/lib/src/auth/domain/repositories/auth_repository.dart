import 'package:educationapp/core/enums/update_user.dart';
import 'package:educationapp/core/utils/typedef.dart';
import 'package:educationapp/src/auth/domain/entities/user.dart';

abstract class AuthRepository {
  const AuthRepository();

  ResultFuture<void> forgotPassword(String email);

  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  });

  ResultFuture<void> signUp({
    required String email,
    required String fullname,
    required String password,
  });

  // UpdateUserAction => enum para saber qué modificar
  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  ResultFuture<void> forgotPassword(String email) {
    throw UnimplementedError();
  }

  @override
  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
  }

  @override
  ResultFuture<void> signUp({
    required String email,
    required String fullname,
    required String password,
  }) {
    throw UnimplementedError();
  }

  @override
  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  }) {
    throw UnimplementedError();
  }
}
