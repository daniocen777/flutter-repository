import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

import 'data/datasource/news_api_datasource.dart';
import 'data/repositories/news_repositgory_impl.dart';
import 'data/utils/http.dart';
import 'domain/datasource/news_datasource.dart';
import 'domain/repositories/news_repository.dart';
import 'domain/usecases/news/get_articles_use_case.dart';
import 'presentation/blocs/article/article_bloc.dart';
import 'presentation/blocs/counter/counter_bloc.dart';
import 'presentation/blocs/employee/employee_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Blocs
  getIt.registerFactory(() => ArticleBloc(getArticlesUseCase: getIt()));
  getIt.registerFactory(() => CounterBloc());
  getIt.registerFactory(() => EmployeeBloc());
  // Casos de uso
  getIt.registerLazySingleton(() => GetArticlesUseCase(getIt()));
  // Repos
  getIt
      .registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(getIt()));
  // Datasources
  getIt.registerLazySingleton<NewsDatasource>(() => NewsAPIDatasource(getIt()));

  // Core

  // External
  getIt.registerLazySingleton(() => Http(
        client: Client(),
        baseUrl: 'https://newsapi.org/v2',
        apiKey: '742981f7037949c4a2965b055f8a7c43',
      ));
}
