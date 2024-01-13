import 'package:dartz/dartz.dart';
import 'package:educationapp/src/auth/domain/repositories/auth_repository.dart';
import 'package:educationapp/src/auth/domain/usecases/sign_up.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_auth_repository.dart';

void main() {
  late AuthRepository repository;
  late SignUp usecase;

  setUp(() {
    repository = MockAuthRepository();
    usecase = SignUp(repository);
  });

  const testEmail = 'testEmail';
  const testPassword = 'testPassword';
  const testFullname = 'testFullname';

  test('debe llamar a [AuthRepository.signUp] y no devolver nada', () async {
    // Arrange
    when(
      () => repository.signUp(
        email: any(named: 'email'),
        fullname: any(named: 'fullname'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => const Right(null));
    // Act
    final result = await usecase(
      const SignUpParams(
        email: testEmail,
        fullname: testFullname,
        password: testPassword,
      ),
    );
    // Seert
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(
      () => repository.signUp(
        email: testEmail,
        fullname: testFullname,
        password: testPassword,
      ),
    ).called(1);
    verifyNoMoreInteractions(repository);
  });
}
