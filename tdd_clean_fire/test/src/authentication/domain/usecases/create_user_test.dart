// 1. De que depende la clase => AuthenticationRepository
// 2. Como puedo crear una version falsa de la dependencia (librerias http) => MockTail
// 3. ¿Cómo controlamos lo que hace nuestra dependencia? => Usando MockTail APIs

// Clase falsa
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_fire/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_clean_fire/src/authentication/domain/usecases/create_user.dart';

import 'authentication_repository.mock.dart';

// class MockAuthRepo extends Mock implements AuthenticationRepository {}

void main() {
  late CreateUser usecase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    usecase = CreateUser(repository);
  });

  const params = CreateUserParams.empty();

  test('debe llamar a [AuthRepo.createUser]', () async {
    // ## Arreglar (lo que se necesita para ejecutar la prueba) => caso de uso
    // Cuando se llame al repositorio, crear los parmaentros
    when(
      () => repository.createUser(
        createdAt: any(named: 'createdAt'),
        name: any(named: 'name'),
        avatar: any(named: 'avatar'),
      ),
    ).thenAnswer((_) async => const Right(null));
    // ## Ejecutar
    final result = await usecase(params);
    // ## Afirmacion
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(() => repository.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar)).called(1);

    verifyNoMoreInteractions(repository);
  });
}
