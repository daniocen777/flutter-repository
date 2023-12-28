import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_fire/core/errors/exceptions.dart';
import 'package:tdd_clean_fire/core/errors/failure.dart';
import 'package:tdd_clean_fire/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_clean_fire/src/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:tdd_clean_fire/src/authentication/domain/entities/user.dart';

// Depende de...
class MockAuthRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImpl repositoryImpl;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    repositoryImpl = AuthenticationRepositoryImpl(remoteDataSource);
  });

  const testException =
      APIException(message: 'unknow Error Occured', statusCode: 500);

  group('createUser', () {
    const createdAt = 'whatever.createdAt';
    const name = 'whatever.name';
    const avatar = 'whatever.avatar';
    test('debe llamar a [RemoteDataSource.createUser] correctamente', () async {
      // Arrange => Crear los parametro cuando se llame al datasource para crear usuario
      when(() => remoteDataSource.createUser(
              createdAt: any(named: 'createdAt'),
              name: any(named: 'name'),
              avatar: any(named: 'avatar')))
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await repositoryImpl.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );
      // Assert
      expect(result, equals(const Right(null))); // void
      // Comprobar que el datasource remoto para crear usuario (createUser) sea llamado
      verify(() => remoteDataSource.createUser(
            createdAt: createdAt,
            name: name,
            avatar: avatar,
          )).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'debe retornar un [APIFailure] cuando la llamada al datasource remoto sea errónea',
        () async {
      // Arrange => Crear los parametro cuando se llame al datasource para crear usuario
      when(() => remoteDataSource.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'))).thenThrow(testException);

      // Acto
      final result = await repositoryImpl.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      // Assert
      expect(
        result,
        equals(
          Left(
            APIFailure(
                message: testException.message,
                statusCode: testException.statusCode),
          ),
        ),
      );
      // Comprobar que el datasource remoto para crear usuario (createUser) sea llamado
      verify(() => remoteDataSource.createUser(
            createdAt: createdAt,
            name: name,
            avatar: avatar,
          )).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('getUsers', () {
    test(
        'debe llamar a [RemoteDataSource.getUsers] y retornar [List<User>] correctamente',
        () async {
      when(() => remoteDataSource.getUsers()).thenAnswer((_) async => []);
      // Act
      final result = await repositoryImpl.getUsers();
      // Assert
      expect(result, isA<Right<dynamic, List<User>>>());
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  test(
      'debe retornar un [APIFailure] cuando la llamada al datasource remoto sea errónea',
      () async {
    // Arrange
    when(() => remoteDataSource.getUsers()).thenThrow(testException);
    // Act
    final result = await repositoryImpl.getUsers();
    // Assert
    expect(result, equals(Left(APIFailure.fromException(testException))));
    verify(() => remoteDataSource.getUsers()).called(1);
    verifyNoMoreInteractions(remoteDataSource);
  });
}
