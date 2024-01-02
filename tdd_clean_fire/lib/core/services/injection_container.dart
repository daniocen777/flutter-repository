// service locator
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../src/authentication/data/datasources/authentication_remote_data_source.dart';
import '../../src/authentication/data/repositories/authentication_repository_impl.dart';
import '../../src/authentication/domain/repositories/authentication_repository.dart';
import '../../src/authentication/domain/usecases/create_user.dart';
import '../../src/authentication/domain/usecases/get_users.dart';
import '../../src/authentication/presentation/cubits/authentication/authentication_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    // Blocs | Cubits
    ..registerFactory(
        () => AuthenticationCubit(createUser: sl(), getUsers: sl()))
    // Casos de uso
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))
    // repos
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImpl(sl()))
    // datasources
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthenticationRemoteDataSourceImpl(sl()))
    // External
    ..registerLazySingleton(() => http.Client());

  /* sl.registerLazySingleton(() => CreateUser(sl()));
  sl.registerLazySingleton(() => GetUsers(repository: sl())); */
}
