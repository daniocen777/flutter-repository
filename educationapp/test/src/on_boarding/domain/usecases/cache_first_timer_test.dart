import 'package:dartz/dartz.dart';
import 'package:educationapp/core/errors/failures.dart';
import 'package:educationapp/src/on_boarding/domain/repositories/on_boarding_repository.dart';
import 'package:educationapp/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'on_boarding_repository.mock.dart';

void main() {
  late OnBoardingRepository repository;
  late CacheFirstTimer usecase;

  setUp(() {
    // Crear dependencia MockOnBoardingRepository
    repository = MockOnBoardingRepository();
    usecase = CacheFirstTimer(repository);
  });

  group('cacheFirstTimer', () {
    test(
      'debe llamar a [OnBoardingRepository.cacheFirstTimer] '
      'y devolver la data correcta (void)',
      () async {
        // Arraange
        when(() => repository.cacheFirstTimer())
            .thenAnswer((_) async => const Right(null));
        // Act
        final result = await usecase();
        // Assert
        expect(result, equals(const Right<dynamic, void>(null)));
        verify(() => repository.cacheFirstTimer()).called(1);
        verifyNoMoreInteractions(repository);
      },
    );

    test(
      'debe llamar a [OnBoardingRepository.cacheFirstTimer] '
      'y devolver error [ServerFailure]',
      () async {
        // Arraange
        when(() => repository.cacheFirstTimer()).thenAnswer(
          (_) async => Left(
            ServerFailure(
              message: 'Unknown Error Occurred',
              statusCode: 500,
            ),
          ),
        );
        // Act
        final result = await usecase();
        // Assert
        expect(
          result,
          equals(
            Left<Failure, dynamic>(
              ServerFailure(message: 'Unknown Error Occurred', statusCode: 500),
            ),
          ),
        );
        verify(() => repository.cacheFirstTimer()).called(1);
        verifyNoMoreInteractions(repository);
      },
    );
  });
}
