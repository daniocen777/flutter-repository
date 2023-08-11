import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/data/http/http.dart';
import 'app/data/repositories_impl/account_repository_impl.dart';
import 'app/data/repositories_impl/authentication_repository_impl.dart';
import 'app/data/repositories_impl/connectivity_repository_impl.dart';
import 'app/data/repositories_impl/movie_repository_impl.dart';
import 'app/data/repositories_impl/trending_repository_impl.dart';
import 'app/data/services/local/session_service.dart';
import 'app/data/services/remote/account_api.dart';
import 'app/data/services/remote/authentication_api.dart';
import 'app/data/services/remote/internet_checker.dart';
import 'app/data/services/remote/movies_api.dart';
import 'app/data/services/remote/trending_api.dart';
import 'app/domain/repositories/account_repository.dart';
import 'app/domain/repositories/authentication_repository.dart';
import 'app/domain/repositories/connectivity_repository.dart';
import 'app/domain/repositories/movie_repository.dart';
import 'app/domain/repositories/trending_repository.dart';
import 'app/my_app.dart';
import 'app/presentation/global/controllers/favorites/favorites_controller.dart';
import 'app/presentation/global/controllers/favorites/state/favorites_state.dart';
import 'app/presentation/global/controllers/session_controller.dart';

/* void main() {
  runApp(
    Provider<ConnectivityRepository>(
    create: (context) =>
        ConnectivityRepositoryImpl(Connectivity(), InternetChecker()),
    child: Provider<AuthenticationRepository>(
      create: (context) => AuthenticationRepositoryImpl(
        const FlutterSecureStorage(),
        AuthenticationApi(Http(
            client: http.Client(),
            baseUrl: 'https://api.themoviedb.org/3',
            apiKey: '41dbef11a24e94c01add05a23078ab28')),
      ),
      child: const MyApp(),
    ),

    /* Injector(
        /* connectivityRepository:
            ConnectivityRepositoryImpl(Connectivity(), InternetChecker()), */

        authenticationRepository: AuthenticationRepositoryImpl(
            const FlutterSecureStorage(),
            AuthenticationApi(Http(
                client: http.Client(),
                baseUrl: 'https://api.themoviedb.org/3',
                apiKey: '41dbef11a24e94c01add05a23078ab28'))),
        child: const MyApp()), */
  ));
} */

void main() {
  setPathUrlStrategy(); // Para las rutas (remueve '/#')
  final sessionService = SessionService(const FlutterSecureStorage());
  final http = Http(
      client: Client(),
      baseUrl: 'https://api.themoviedb.org/3',
      apiKey: '41dbef11a24e94c01add05a23078ab28');

  final accountAPI = AccountApi(http, sessionService);
  runApp(
    // ES IMPORTANTE EL ORDEN
    MultiProvider(
      providers: [
        // Para la conexión a internet
        Provider<ConnectivityRepository>(
          create: (_) =>
              ConnectivityRepositoryImpl(Connectivity(), InternetChecker()),
        ),
        // Para la autenticación
        Provider<AuthenticationRepository>(
            create: (_) => AuthenticationRepositoryImpl(
                AuthenticationApi(http), accountAPI, sessionService)),
        // Para obtener datos de la cuenta
        Provider<AccountRepository>(
            create: (_) => AccountRepositoryImpl(accountAPI, sessionService)),
        // Para consumir el api (Trending)
        Provider<TrendingRepository>(
            create: (_) => TrendingRepositoryImpl(TrendingAPI(http))),
        // Para obtener una pelicula
        Provider<MovieRepository>(
            create: (_) => MovieRepositoryImpl(MoviesApi(http))),
        // Para los estados globales - pueden modificarse, se debe notifocar cuando cambien (Usuario, lista de favoritos)
        // ES IMPORTANTE EL ORDEN => SessionController usa AuthenticationRepository
        ChangeNotifierProvider<SessionController>(
            create: (context) =>
                SessionController(authenticationRepository: context.read())),
        ChangeNotifierProvider<FavoritesController>(
            create: (context) => FavoritesController(FavoritesState.loading(),
                accountRepository: context.read())),
      ],
      child: const MyApp(),
    ),
  );
}

// Inyectar los repositories
/* class Injector extends InheritedWidget {
  const Injector(
      {super.key,
      required super.child,
      //required this.connectivityRepository,
      required this.authenticationRepository});

  // final ConnectivityRepository connectivityRepository;
  final AuthenticationRepository authenticationRepository;

  // Notifica a los widgets hijos si los datos de InheritedWidget ha cambiado
  @override
  bool updateShouldNotify(oldWidget) => false;

  static Injector of(BuildContext context) {
    final injector = context.dependOnInheritedWidgetOfExactType<Injector>();
    assert(injector != null,
        'Injector could not be found'); // Si no cumple validacion, se interrunpe la app
    return injector!;
  }
} */
