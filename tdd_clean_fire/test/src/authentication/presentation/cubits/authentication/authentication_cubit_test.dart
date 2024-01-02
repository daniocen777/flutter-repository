// Cubits depende de los casos de usos
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_fire/core/errors/failure.dart';
import 'package:tdd_clean_fire/src/authentication/domain/usecases/create_user.dart';
import 'package:tdd_clean_fire/src/authentication/domain/usecases/get_users.dart';
import 'package:tdd_clean_fire/src/authentication/presentation/cubits/authentication/authentication_cubit.dart';

class MockGetUsers extends Mock implements GetUsers {}

class MockCreateUser extends Mock implements CreateUser {}

void main() {
  late GetUsers getUsers;
  late CreateUser createUser;
  late AuthenticationCubit cubit;

  const testCreateUserParams = CreateUserParams.empty();
  const testAPIFailure = APIFailure(message: 'message', statusCode: 400);

  setUp(() {
    getUsers = MockGetUsers();
    createUser = MockCreateUser();
    cubit = AuthenticationCubit(createUser: createUser, getUsers: getUsers);
    // registrar
    registerFallbackValue(testCreateUserParams);
  });

  // Al terminar las pruebas, cerrar el bloc (cubit)
  tearDown(() => cubit.close());

  test('El estado unicial debe ser [AuthenticationInitial]', () async {
    expect(cubit.state, const AuthenticationInitial());
  });

  group('createUser', () {
    blocTest<AuthenticationCubit, AuthenticationState>(
        'debe emitir el estado [CreatingUser, UserCreated] al ejecutarse correctamente',
        build: () {
          when(() => createUser(any()))
              .thenAnswer((_) async => const Right(null));
          return cubit;
        },
        act: (AuthenticationCubit cubit) => cubit.createUser(
              createdAt: testCreateUserParams.createdAt,
              name: testCreateUserParams.name,
              avatar: testCreateUserParams.avatar,
            ),
        expect: () =>
            const <AuthenticationState>[CreatingUser(), UserCreated()],
        verify: (_) {
          verify(() => createUser(testCreateUserParams)).called(1);
          verifyNoMoreInteractions(createUser);
        });

    blocTest<AuthenticationCubit, AuthenticationState>(
        'debe emitir el estado [CreatingUser, AuthenticationError] al ejecutarse erróneamente',
        build: () {
          when(() => createUser(any()))
              .thenAnswer((_) async => const Left(testAPIFailure));
          return cubit;
        },
        act: (AuthenticationCubit cubit) => cubit.createUser(
              createdAt: testCreateUserParams.createdAt,
              name: testCreateUserParams.name,
              avatar: testCreateUserParams.avatar,
            ),
        expect: () => <AuthenticationState>[
              const CreatingUser(),
              AuthenticationError(testAPIFailure.errorMessage)
            ],
        verify: (_) {
          verify(() => createUser(testCreateUserParams)).called(1);
          verifyNoMoreInteractions(createUser);
        });
  });

  group('getUsers', () {
    blocTest<AuthenticationCubit, AuthenticationState>(
        'debe emitir el estado [GettingUsers, UsersLoaded] al ejecutarse correctamente',
        build: () {
          when(() => getUsers()).thenAnswer((_) async => const Right([]));
          return cubit;
        },
        act: (AuthenticationCubit cubit) => cubit.getUsers(),
        expect: () =>
            <AuthenticationState>[const GettingUsers(), const UsersLoaded([])],
        verify: (_) {
          verify(() => getUsers()).called(1);
          verifyNoMoreInteractions(getUsers);
        });

    blocTest<AuthenticationCubit, AuthenticationState>(
        'debe emitir el estado [GettingUsers, AuthenticationError] al ejecutarse erróneamente',
        build: () {
          when(() => getUsers())
              .thenAnswer((_) async => const Left(testAPIFailure));
          return cubit;
        },
        act: (AuthenticationCubit cubit) => cubit.getUsers(),
        expect: () => <AuthenticationState>[
              const GettingUsers(),
              AuthenticationError(testAPIFailure.errorMessage)
            ],
        verify: (_) {
          verify(() => getUsers()).called(1);
          verifyNoMoreInteractions(getUsers);
        });
  });
}
