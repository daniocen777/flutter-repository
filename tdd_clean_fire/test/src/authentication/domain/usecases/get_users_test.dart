import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_fire/src/authentication/domain/entities/user.dart';
import 'package:tdd_clean_fire/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_clean_fire/src/authentication/domain/usecases/get_users.dart';

import 'authentication_repository.mock.dart';

void main() {
  late AuthenticationRepository repository;
  late GetUsers usecase;

  setUp(() async {
    repository = MockAuthRepo();
    usecase = GetUsers(repository: repository);
  });

  const testResponse = [User.empty()];

  test('debe llamar a [AuthRepo.getUsers] y retornar [List<User>]', () async {
    // arranque
    when(() => repository.getUsers())
        .thenAnswer((_) async => const Right(testResponse));
    // Act
    final result = await usecase();
    expect(result, equals(const Right<dynamic, List<User>>(testResponse)));
    verify(() => repository.getUsers()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
