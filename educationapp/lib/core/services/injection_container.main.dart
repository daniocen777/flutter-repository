part of 'injection_container.dart';

final sl = GetIt.instance; // service locator

Future<void> init() async {
  // On Boarding Feature
  await _initOnBoarding();
  // Auth
  await _initAuth();
}

Future<void> _initOnBoarding() async {
  final preferences = await SharedPreferences.getInstance();
  // Blocs
  sl
    ..registerFactory(
      () => OnBoardingCubit(
        cacheFirstTimer: sl(),
        checkIfUserIsFirstTimer: sl(),
      ),
    )
    // Casos de uso
    ..registerLazySingleton(() => CacheFirstTimer(sl()))
    ..registerLazySingleton(() => CheckIfUserIsFirstTimer(sl()))
    // Repositorios
    ..registerLazySingleton<OnBoardingRepository>(
      () => OnBoardingRepositoryImpl(sl()),
    )
    // Datasources
    ..registerLazySingleton<OnBoardingLocalDataSource>(
      () => OnBoardingLocalDataSourceImpl(sl()),
    )
    // External
    ..registerLazySingleton(
      () => preferences,
    );
}

Future<void> _initAuth() async {
  // Blocs
  sl
    ..registerFactory(
      () => AuthBloc(
        signIn: sl(),
        signUp: sl(),
        forgotPassword: sl(),
        updateUser: sl(),
      ),
    )
    // Casos de uso
    ..registerLazySingleton(() => SignIn(sl()))
    ..registerLazySingleton(() => SignUp(sl()))
    ..registerLazySingleton(() => ForgotPassword(sl()))
    ..registerLazySingleton(() => UpdateUser(sl()))
    // Repos
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()))
    // Datasources
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        firebaseAuth: sl(),
        firestore: sl(),
        storage: sl(),
      ),
    )
    // External
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance);
}
