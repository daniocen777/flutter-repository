import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:educationapp/core/errors/failures.dart';
import 'package:educationapp/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:educationapp/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:educationapp/src/on_boarding/presentation/cubits/on_boarding_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Dependencias
class MockCacheFirstTimer extends Mock implements CacheFirstTimer {}

class MockCheckIfUserIsFirstTimerCacheFirstTimer extends Mock
    implements CheckIfUserIsFirstTimer {}

void main() {
  late CacheFirstTimer cacheFirstTimer;
  late CheckIfUserIsFirstTimer checkIfUserIsFirstTimer;
  late OnBoardingCubit cubit;

  setUp(() {
    cacheFirstTimer = MockCacheFirstTimer();
    checkIfUserIsFirstTimer = MockCheckIfUserIsFirstTimerCacheFirstTimer();
    cubit = OnBoardingCubit(
      cacheFirstTimer: cacheFirstTimer,
      checkIfUserIsFirstTimer: checkIfUserIsFirstTimer,
    );
  });

  final testFailure = CacheFailure(
    message: 'Insufficient Permissions',
    statusCode: 402,
  );

  test('El estado inicial debe ser [OnBoardingInitial]', () {
    expect(cubit.state, const OnBoardingInitial());
  });

  group('cacheFirstTimer', () {
    blocTest<OnBoardingCubit, OnBoardingState>(
      'debe emitir [CachingFirstTimerState, UserCachedState] '
      'cuando sea correcto',
      build: () {
        when(() => cacheFirstTimer())
            .thenAnswer((_) async => const Right(null));
        return cubit;
      },
      act: (OnBoardingCubit cubit) => cubit.cacheFirstTimer(),
      expect: () => const [CachingFirstTimerState(), UserCachedState()],
      verify: (_) {
        verify(() => cacheFirstTimer()).called(1);
        verifyNoMoreInteractions(cacheFirstTimer);
      },
    );

    blocTest<OnBoardingCubit, OnBoardingState>(
      'debe emitir [CachingFirstTimerState, OnBoardingErrorState] '
      'cuando haya un error',
      build: () {
        when(() => cacheFirstTimer()).thenAnswer(
          (_) async => Left(testFailure),
        );
        return cubit;
      },
      act: (OnBoardingCubit cubit) => cubit.cacheFirstTimer(),
      expect: () => [
        const CachingFirstTimerState(),
        OnBoardingErrorState(testFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => cacheFirstTimer()).called(1);
        verifyNoMoreInteractions(cacheFirstTimer);
      },
    );

    group('checkIfUserIsFirstTimer', () {
      blocTest<OnBoardingCubit, OnBoardingState>(
        'debe emitir [CheckingIfUserIsFirstTimerState, OnBoardingStatus] '
        'cuando se correcto',
        build: () {
          when(() => checkIfUserIsFirstTimer())
              .thenAnswer((_) async => const Right(false));
          return cubit;
        },
        act: (cubit) => cubit.checkIfUserIsFirstTimer(),
        expect: () => const [
          CheckingIfUserIsFirstTimerState(),
          OnBoardingStatus(isFirstTimer: false),
        ],
        verify: (_) {
          verify(() => checkIfUserIsFirstTimer()).called(1);
          verifyNoMoreInteractions(checkIfUserIsFirstTimer);
        },
      );

      blocTest<OnBoardingCubit, OnBoardingState>(
        'debe emitir [CheckingIfUserIsFirstTimerState, OnBoardingStatus(true)] '
        'cuando haya error',
        build: () {
          when(() => checkIfUserIsFirstTimer())
              .thenAnswer((_) async => Left(testFailure));
          return cubit;
        },
        act: (cubit) => cubit.checkIfUserIsFirstTimer(),
        expect: () => const [
          CheckingIfUserIsFirstTimerState(),
          OnBoardingStatus(isFirstTimer: true),
        ],
        verify: (_) {
          verify(() => checkIfUserIsFirstTimer()).called(1);
          verifyNoMoreInteractions(checkIfUserIsFirstTimer);
        },
      );
    });
  });
}
