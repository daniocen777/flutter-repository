// Depende de http
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_fire/core/errors/exceptions.dart';
import 'package:tdd_clean_fire/core/utils/constants.dart';
import 'package:tdd_clean_fire/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_clean_fire/src/authentication/data/models/user_model.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthenticationRemoteDataSourceImpl(client);
    registerFallbackValue(Uri()); // client.post(any() ...
  });

  group('createUser', () {
    test('debe completarse correctamente cuando el statusCode es 200 0 201',
        () async {
      // Arrange
      when(
        () => client.post(
          any(),
          body: any(named: 'body'),
          headers: {'Content-Type': 'application/json'},
        ),
      ).thenAnswer(
        (_) async => http.Response(
          'Usuario creado correctamente',
          201,
        ),
      );
      // Act
      final methodCall = remoteDataSource.createUser;
      // Assert
      expect(
          methodCall(
            createdAt: 'createdAt',
            name: 'name',
            avatar: 'avatar',
          ),
          completes);

      verify(
        () => client.post(
          Uri.https(
            kBaseUrl,
            createUserEndpoint,
          ),
          body: jsonEncode(
            {
              'createdAt': 'createdAt',
              'name': 'name',
            },
          ),
          headers: {'Content-Type': 'application/json'},
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    test(
        'debe lanzar una excepción [APIException] cuando el statusCode no es 200 o 201',
        () async {
      // Arrange
      when(
        () => client.post(
          any(),
          body: any(named: 'body'),
          headers: {'Content-Type': 'application/json'},
        ),
      ).thenAnswer(
        (_) async => http.Response(
          'Invalid email address',
          400,
        ),
      );
      // Act
      final methodCall = remoteDataSource.createUser;
      expect(
          () async => methodCall(
                createdAt: 'createdAt',
                name: 'name',
                avatar: 'avatar',
              ),
          throwsA(
            const APIException(
                message: 'Invalid email address', statusCode: 400),
          ));
      // Assert
      verify(
        () => client.post(
          Uri.https(kBaseUrl, createUserEndpoint),
          body: jsonEncode(
            {
              'createdAt': 'createdAt',
              'name': 'name',
            },
          ),
          headers: {'Content-Type': 'application/json'},
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });

  group('getUsers', () {
    const testUsers = [UserModel.empty()];

    test(
        'debe retornar una lista [List<User>] cuando el statusCode sea 200 0 201 ',
        () async {
      when(() => client.get(any())).thenAnswer((_) async =>
          http.Response(jsonEncode([testUsers.first.toMap()]), 200));
      // Act
      final result = await remoteDataSource.getUsers();
      expect(result, equals(testUsers));
      // Assert
      verify(
        () => client.get(Uri.https(kBaseUrl, getUsersEndpoint)),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    test(
        'debe lanzar la excepción [APIException] cuando statusCode sea diferente de 200 o 201',
        () async {
      const testMessage = 'Servidor caído';
      // Arrange
      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response(testMessage, 500));
      // Act
      final methodCall = remoteDataSource.getUsers();
      // Assert
      expect(() => methodCall,
          throwsA(const APIException(message: testMessage, statusCode: 500)));

      verify(
        () => client.get(Uri.https(kBaseUrl, getUsersEndpoint)),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });
}
