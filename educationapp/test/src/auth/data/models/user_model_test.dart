import 'dart:convert';

import 'package:educationapp/core/utils/typedef.dart';
import 'package:educationapp/src/auth/data/models/user_model.dart';
import 'package:educationapp/src/auth/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const testLocalUserModel = LocalUserModel.empty();

  test(
    'debe ser una subclase de la entidad[LocalUser]',
    () => expect(testLocalUserModel, isA<LocalUser>()),
  );

  final testMap = jsonDecode(fixture('user.json')) as DataMap;
  group('fromMap', () {
    test('debe retornar datos válidos de [LocalUserModel] de un map', () {
      // Act
      final result = LocalUserModel.fromMap(testMap);
      // Assert
      expect(result, isA<LocalUserModel>());
      expect(result, equals(testLocalUserModel));
    });

    test('debe lanzar [Error] cuando el map in inválido', () {
      final map = DataMap.from(testMap)..remove('uid');
      // Act
      const call = LocalUserModel.fromMap;
      // Assert
      expect(() => call(map), throwsA(isA<Error>()));
    });
  });

  group('toMap', () {
    test('debe retornar un [DataMap] válido del modelo [UserModel]', () {
      final result = testLocalUserModel.toMap();
      // Assert
      expect(result, equals(testMap));
    });
  });

  group('copyWith', () {
    test(
      'debe retornar modelo [LocalUserMode] válido con valores actualizados',
      () {
        final result = testLocalUserModel.copiWith(uid: '2');
        // Assert
        expect(result.uid, '2');
      },
    );
  });
}
