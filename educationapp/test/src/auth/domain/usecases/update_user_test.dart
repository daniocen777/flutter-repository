import 'package:dartz/dartz.dart';
import 'package:educationapp/core/enums/update_user.dart';
import 'package:educationapp/src/auth/domain/repositories/auth_repository.dart';
import 'package:educationapp/src/auth/domain/usecases/update_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_auth_repository.dart';

void main() {
  late AuthRepository repository;
  late UpdateUser usecase;

  setUp(() {
    repository = MockAuthRepository();
    usecase = UpdateUser(repository);
    registerFallbackValue(UpdateUserAction.email);
  });

  /* const testParams = UpdateUserParams(
    action: UpdateUserAction.email,
    userData: 'testEmail',
  ); */

  const testAction = UpdateUserAction.email;
  const testUserData = 'testEmail';

  test(
    'debe llamar a [AuthRepository.updateUser] y no devolver nada',
    () async {
      // Arrange
      when(
        () => repository.updateUser(
          action: any<UpdateUserAction>(named: 'action'),
          userData: any<dynamic>(named: 'userData'),
        ),
      ).thenAnswer((_) async => const Right(null));
      // Act
      final result = await usecase(
        const UpdateUserParams(action: testAction, userData: testUserData),
      );
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(
        () => repository.updateUser(
          action: testAction,
          userData: testUserData,
        ),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
