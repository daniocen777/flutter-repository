import 'package:dartz/dartz.dart';
import 'package:educationapp/src/auth/domain/entities/user.dart';
import 'package:educationapp/src/auth/domain/repositories/auth_repository.dart';
import 'package:educationapp/src/auth/domain/usecases/sign_in.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_auth_repository.dart';

void main() {
  late AuthRepository repository;
  late SignIn usecase;

  setUp(() {
    repository = MockAuthRepository();
    usecase = SignIn(repository);
  });

  // const params = SignInParams.empty();
  const testEmail = 'testEmail';
  const testPassword = 'testPassword';
  const testLocalUser = LocalUser.empty();

  test('debe retornar [LocalUser] cuando se llame a [AuthRepository.signIn]',
      () async {
    // Arrange
    when(
      () => repository.signIn(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => const Right(testLocalUser));
    // Act
    final result = await usecase(
      const SignInParams(email: testEmail, password: testPassword),
    );
    // Assert
    expect(result, equals(const Right<dynamic, LocalUser>(testLocalUser)));
    verify(
      () => repository.signIn(email: testEmail, password: testPassword),
    ).called(1);
    verifyNoMoreInteractions(repository);
  });
}
