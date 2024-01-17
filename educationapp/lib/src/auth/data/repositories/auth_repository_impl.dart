import 'package:dartz/dartz.dart';
import 'package:educationapp/core/enums/update_user.dart';
import 'package:educationapp/core/errors/exceptions.dart';
import 'package:educationapp/core/errors/failures.dart';
import 'package:educationapp/core/utils/typedef.dart';
import 'package:educationapp/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:educationapp/src/auth/domain/entities/user.dart';
import 'package:educationapp/src/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<void> forgotPassword(String email) async {
    try {
      await _remoteDataSource.forgotPassword(email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result =
          await _remoteDataSource.signIn(email: email, password: password);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> signUp({
    required String email,
    required String fullname,
    required String password,
  }) async {
    try {
      await _remoteDataSource.signUp(
        email: email,
        fullname: fullname,
        password: password,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  }) async {
    await _remoteDataSource.updateUser(action: action, userData: userData);
    try {
      await _remoteDataSource.updateUser(action: action, userData: userData);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
