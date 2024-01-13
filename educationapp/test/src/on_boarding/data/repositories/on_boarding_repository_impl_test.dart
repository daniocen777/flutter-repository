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

  group('checkIfUserIsFirstTimer', () {
    test(
      'debe retornar true cuando el usuario ingresa por primera vez',
      () async {
        // Arrange
        when(() => localDataSource.checkIfUserIsFirstTimer())
            .thenAnswer((_) async => Future.value(true));
        // Act
        final result = await repositoryImpl.checkIfUserIsFirstTimer();
        // Assert
        expect(result, equals(const Right<dynamic, bool>(true)));
        verify(() => localDataSource.checkIfUserIsFirstTimer()).called(1);
        verifyNoMoreInteractions(localDataSource);
      },
    );

    test(
      'debe retornar false cuando el usuario no ingresa por primera vez',
      () async {
        // Arrange
        when(() => localDataSource.checkIfUserIsFirstTimer())
            .thenAnswer((_) async => Future.value(false));
        // Act
        final result = await repositoryImpl.checkIfUserIsFirstTimer();
        // Assert
        expect(result, equals(const Right<dynamic, bool>(false)));
        verify(() => localDataSource.checkIfUserIsFirstTimer()).called(1);
        verifyNoMoreInteractions(localDataSource);
      },
    );

    test(
      'debe retornar un [CacheFailure] cuando la llamada '
      'del datasource sea errónea',
      () async {
        // Arrange
        when(() => localDataSource.checkIfUserIsFirstTimer()).thenThrow(
          const CacheException(
            message: 'Insufficient permissions',
            statusCode: 403,
          ),
        );
        // Act
        final result = await repositoryImpl.checkIfUserIsFirstTimer();
        // Assert
        expect(
          result,
          equals(
            Left<CacheFailure, bool>(
              CacheFailure(
                message: 'Insufficient permissions',
                statusCode: 403,
              ),
            ),
          ),
        );

        verify(() => localDataSource.checkIfUserIsFirstTimer()).called(1);
        verifyNoMoreInteractions(localDataSource);
      },
    );
  });
}
