import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movies_clean_architecture/core/network/network_info.dart';
import 'package:movies_clean_architecture/features/movies/data/datasources/movie_remote_datasource.dart';
import 'package:movies_clean_architecture/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:movies_clean_architecture/features/movies/domain/repositories/movies_repository.dart';
import 'package:movies_clean_architecture/features/movies/domain/usercases/get_movies.dart';
import 'package:movies_clean_architecture/features/movies/presentation/blocs/movies/movies_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Blocs
  getIt.registerFactory(() => MoviesBloc(getMovies: getIt()));
  // usecases
  getIt.registerLazySingleton(() => GetMoviesUserCase(getIt()));
  // Repositories, por demanda
  getIt.registerLazySingleton<MoviesRepository>(() =>
      MovieRepositoryImpl(remoteDatasource: getIt(), networkInfo: getIt()));
  // Datasources
  getIt.registerLazySingleton<MovieRemoteDatasource>(
      () => MovieRemoteDatasourceImpl(client: getIt()));

  // Core
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));
  // External
  getIt.registerLazySingleton(() => http.Client());
  getIt.registerLazySingleton(() => InternetConnectionChecker());
}
