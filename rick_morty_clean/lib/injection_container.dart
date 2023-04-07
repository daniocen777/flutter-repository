import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rick_morty_clean/core/network/network_info.dart';
import 'package:rick_morty_clean/features/rick_and_morty/data/datasources/remote_datasource.dart';
import 'package:rick_morty_clean/features/rick_and_morty/data/repositories/characters_repocitory_impl.dart';
import 'package:rick_morty_clean/features/rick_and_morty/domain/repositories/characters_repository.dart';
import 'package:rick_morty_clean/features/rick_and_morty/domain/usecases/rick_and_morty_usecase/get_all_characters.dart';
import 'package:rick_morty_clean/features/rick_and_morty/domain/usecases/rick_and_morty_usecase/get_all_characters_paginated.dart';
import 'package:rick_morty_clean/features/rick_and_morty/presentation/blocs/character_bloc/character_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Features: posts
  // Blocs
  getIt.registerFactory(() => CharacterBloc(
      getAllCharacters: getIt(), getAllCharactersPaginated: getIt()));
  // Usescases, por demanda
  getIt.registerLazySingleton(() => GetAllCharactersUseCase(getIt()));
  getIt.registerLazySingleton(() => GetAllCharactersPaginatedUseCase(getIt()));
  // Repositories, por demanda
  getIt.registerLazySingleton<CharactersRepository>(() =>
      CharactersRepositoryImpl(
          remoteDatasource: getIt(), networkInfo: getIt()));
  // Datasources
  getIt.registerLazySingleton<RemoteDatasource>(
      () => RemoteDatasourceImpl(client: getIt()));
  // Core
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));
  // External
  // final sharedPreferences = await SharedPreferences.getInstance();
  // getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => http.Client());
  getIt.registerLazySingleton(() => InternetConnectionChecker());
}
