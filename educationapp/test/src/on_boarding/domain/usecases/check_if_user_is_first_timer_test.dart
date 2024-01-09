import 'package:dartz/dartz.dart';
import 'package:educationapp/src/on_boarding/domain/repositories/on_boarding_repository.dart';
import 'package:educationapp/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'on_boarding_repository.mock.dart';

void main() {
  late OnBoardingRepository repository;
  late CheckIfUserIsFirstTimer usecase;

  setUp(() {
    // Crear dependencia MockOnBoardingRepository
    repository = MockOnBoardingRepository();
    usecase = CheckIfUserIsFirstTimer(repository);
  });

  test('debe obtener una respuesta de [OnBoardingRepository] ', () async {
    // Arrange
    when(() => repository.checkIfUserIsFirstTimer())
        .thenAnswer((_) async => const Right(true));

    // Act
    final result = await usecase();

    // Assert
    expect(result, equals(const Right<dynamic, bool>(true)));
    verify(() => repository.checkIfUserIsFirstTimer()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
