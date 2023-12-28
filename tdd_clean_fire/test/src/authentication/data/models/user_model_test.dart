// Modelo no depende de nada

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_fire/core/utils/typedef.dart';
import 'package:tdd_clean_fire/src/authentication/data/models/user_model.dart';
import 'package:tdd_clean_fire/src/authentication/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const testModel = UserModel.empty();

  test('debe ser una subclase de la entidad User', () {
    // arrange => testModel
    // assert
    expect(testModel, isA<User>());
  });

  final testJson = fixture('user.json');
  final testMap = jsonDecode(testJson) as DataMap;

  group('fromMap', () {
    test('Debe retornar un [UserModel] con la data correcta', () {
      // arrange => testMap
      // final testJson = File('test/fixtures/user.json').readAsStringSync();
      // Act
      final result = UserModel.fromMap(testMap);
      expect(result, equals(testModel));
    });
  });

  group('fromJson', () {
    test('Debe retornar un [UserModel] con la data correcta', () {
      // arrange => testJson
      // Act
      final result = UserModel.fromJson(testJson);
      // Assert
      expect(result, equals(testModel));
    });
  });

  group('toMap', () {
    test('Debe retornar un [Map] con la data correcta', () {
      // Act
      final result = testModel.toMap();
      // Assert
      expect(result, equals(testMap));
    });
  });

  group('toJson', () {
    test('Debe retornar una cadena [JSON] con la data correcta', () {
      // Act
      final result = testModel.toJson();
      final testJson = jsonEncode({
        "id": "1",
        "avatar": "_empty.avatar",
        "createdAt": "_empty.createdAt",
        "name": "_empty.name"
      });
      // Assert
      expect(result.trim(), equals(testJson));
    });
  });

  group('copyWitht', () {
    test('Debe retornar un [UserModel] con datos diferentes', () {
      // Arrange
      // Act
      final result = testModel.copyWith(name: 'Lola');
      // Assert
      expect(result.name, equals('Lola'));
    });
  });
}
