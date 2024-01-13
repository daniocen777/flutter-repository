import 'package:dartz/dartz.dart';
import 'package:educationapp/src/auth/domain/repositories/auth_repository.dart';
import 'package:educationapp/src/auth/domain/usecases/forgot_password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_auth_repository.dart';

void main() {
  late AuthRepository repository;
  late ForgotPassword usecase;

  setUp(() {
    repository = MockAuthRepository();
    usecase = ForgotPassword(repository);
  });

  const testEmail = 'testEmail';

  test(
    'debe llamar a [AuthRepository.forgotPassword] y no retornar nada',
    () async {
      // Arrange
      when(() => repository.forgotPassword(any()))
          .thenAnswer((_) async => const Right(null));
      // Act
      final result = await usecase(testEmail);
      // Asert
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(() => repository.forgotPassword(testEmail)).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
