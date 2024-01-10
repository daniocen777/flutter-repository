import 'package:educationapp/core/errors/exceptions.dart';
import 'package:educationapp/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences preferences;
  late OnBoardingLocalDataSource localDataSource;

  setUp(() {
    preferences = MockSharedPreferences();
    localDataSource = OnBoardingLocalDataSourceImpl(preferences);
  });

  group('cacheFirstTomer', () {
    test('debe llamar [SharedPreferences] para guardar la data en caché',
        () async {
      // Arrange
      when(() => preferences.setBool(any(), any()))
          .thenAnswer((_) async => true);
      // Act
      await localDataSource.cacheFirstTimer();
      // Assert => cache por primera vez
      verify(() => preferences.setBool(kFirstTimerKey, false)).called(1);
      verifyNoMoreInteractions(preferences);
    });

    test(
      'debe lanzar un [CacheException] cuando haya un error '
      'almacenando la data',
      () async {
        // Arrange
        when(() => preferences.setBool(any(), any())).thenThrow(Exception());
        // Act
        final methodCall = localDataSource.cacheFirstTimer;
        // Asert
        expect(methodCall, throwsA(isA<CacheException>()));
        verify(() => preferences.setBool(kFirstTimerKey, false)).called(1);
        verifyNoMoreInteractions(preferences);
      },
    );
  });

  group('checkIfUserIsFirstTimer', () {
    test(
      'debe llamar [SharedPreferences] para verificar si usuario '
      'ingresa por primera vez y responder con el storage con '
      'la data existente',
      () async {
        // Arrange
        when(() => preferences.getBool(any())).thenReturn(false);
        // Act
        final result = await localDataSource.checkIfUserIsFirstTimer();
        // Assert
        expect(result, false);
        verify(() => preferences.getBool(kFirstTimerKey)).called(1);
        verifyNoMoreInteractions(preferences);
      },
    );

    // Si usuario ingresa por primera vez, no tiene data
    test('debe retornar true si no hay data en el storage', () async {
      // Arrange
      when(() => preferences.getBool(any())).thenReturn(null);
      // Act
      final result = await localDataSource.checkIfUserIsFirstTimer();
      // Assert
      expect(result, true);
      verify(() => preferences.getBool(kFirstTimerKey)).called(1);
      verifyNoMoreInteractions(preferences);
    });

    test(
      'debe lanzar un [CacheException] cuando haya un error '
      'al recuperar la data',
      () async {
        // Arrange
        when(() => preferences.getBool(any())).thenThrow(Exception());
        // Act
        final call = localDataSource.checkIfUserIsFirstTimer;
        // Assert
        expect(call, throwsA(isA<CacheException>()));
        verify(() => preferences.getBool(kFirstTimerKey)).called(1);
        verifyNoMoreInteractions(preferences);
      },
    );
  });
}
