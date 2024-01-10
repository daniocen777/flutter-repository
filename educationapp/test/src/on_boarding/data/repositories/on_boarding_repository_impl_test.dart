// Depende de Datasource
import 'package:dartz/dartz.dart';
import 'package:educationapp/core/errors/exceptions.dart';
import 'package:educationapp/core/errors/failures.dart';
import 'package:educationapp/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:educationapp/src/on_boarding/data/repositories/on_boarding_repository_impl.dart';
import 'package:educationapp/src/on_boarding/domain/repositories/on_boarding_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnBoardingLocalDataSource extends Mock
    implements OnBoardingLocalDataSource {}

void main() {
  late OnBoardingLocalDataSource localDataSource;
  late OnBoardingRepositoryImpl repositoryImpl;

  setUp(() {
    localDataSource = MockOnBoardingLocalDataSource();
    repositoryImpl = OnBoardingRepositoryImpl(localDataSource);
  });

  test('debe ser una subclase de [OnBoardingRepository]', () {
    expect(repositoryImpl, isA<OnBoardingRepository>());
  });

  group('cacheFirstTimer', () {
    test(
      'debe completar correctamente cuando se llame a la fuente local',
      () async {
        // Arrange
        when(() => localDataSource.cacheFirstTimer())
            .thenAnswer((_) async => Future.value());

        // Act
        final result = await repositoryImpl.cacheFirstTimer();

        // Assert
        expect(result, equals(const Right<dynamic, void>(null)));
        verify(() => localDataSource.cacheFirstTimer()).called(1);
        verifyNoMoreInteractions(localDataSource);
      },
    );

    test(
      'debe retornar [CacheFailure] cuando la llamada a la fuente local '
      'sea errónea',
      () async {
        // Arrange
        when(() => localDataSource.cacheFirstTimer()).thenThrow(
          const CacheException(message: 'Insufficient storage'),
        );

        // Act
        final result = await repositoryImpl.cacheFirstTimer();

        // Assert
        expect(
          result,
          Left<CacheFailure, dynamic>(
            CacheFailure(
              message: 'Insufficient storage',
              statusCode: 500,
            ),
          ),
        );
        verify(() => localDataSource.cacheFirstTimer()).called(1);
        verifyNoMoreInteractions(localDataSource);
      },
    );
  });
}
