import 'package:educationapp/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:educationapp/src/on_boarding/data/repositories/on_boarding_repository_impl.dart';
import 'package:educationapp/src/on_boarding/domain/repositories/on_boarding_repository.dart';
import 'package:educationapp/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:educationapp/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:educationapp/src/on_boarding/presentation/cubits/on_boarding_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final preferences = await SharedPreferences.getInstance();
  // ***** On Boarding Feature *****
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
