import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_clean_architecture/core/network/network_info.dart';
import 'package:posts_clean_architecture/features/posts/data/datasources/post_local_datasource.dart';
import 'package:posts_clean_architecture/features/posts/data/datasources/post_remote_datasource.dart';
import 'package:posts_clean_architecture/features/posts/data/repositories/post_repository_impl.dart';
import 'package:posts_clean_architecture/features/posts/domain/repositories/posts_repository.dart';
import 'package:posts_clean_architecture/features/posts/domain/usecases/add_post.dart';
import 'package:posts_clean_architecture/features/posts/domain/usecases/delete_post.dart';
import 'package:posts_clean_architecture/features/posts/domain/usecases/get_all_posts.dart';
import 'package:posts_clean_architecture/features/posts/domain/usecases/update_post.dart';
import 'package:posts_clean_architecture/features/posts/presentation/blocs/add_delete_update_posts/add_delete_update_posts_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Features: posts
  // Blocs
  getIt.registerFactory(() => PostsBloc(getAllPosts: getIt()));
  getIt.registerFactory(() => AddDeleteUpdatePostsBloc(
      addPost: getIt(), updatePost: getIt(), deletePost: getIt()));
  // Usescases, por demanda
  getIt.registerLazySingleton(() => GetAllPostsUseCase(getIt()));
  getIt.registerLazySingleton(() => AddPostUsecase(getIt()));
  getIt.registerLazySingleton(() => DeletePostUsecase(getIt()));
  getIt.registerLazySingleton(() => UpdatePostUsecase(getIt()));
  // Repositories, por demanda
  getIt.registerLazySingleton<PostsRepository>(() => PostRepositoryImpl(
      remoteDatasource: getIt(),
      localDataSource: getIt(),
      networkInfo: getIt()));
  // Datasources
  getIt.registerLazySingleton<PostRemoteDatasource>(
      () => PostRemoteDatasourceImpl(client: getIt()));
  getIt.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(sharedPreferences: getIt()));
  // Core
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => http.Client());
  getIt.registerLazySingleton(() => InternetConnectionChecker());
}
