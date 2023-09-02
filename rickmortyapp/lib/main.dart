import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/data/datasources/remote/internet_checker.dart';
import 'app/data/datasources/remote/rick_and_morty_api.dart';
import 'app/data/http/http.dart';
import 'app/data/repositories/connectivity_repository_impl.dart';
import 'app/data/repositories/rick_and_morty_repository_impl.dart';
import 'app/domain/repositories/connectivity_repository.dart';
import 'app/domain/repositories/rick_and_morty_repository.dart';
import 'app/my_app.dart';

void main() {
  setPathUrlStrategy(); // Para las rutas (remueve '/#')
  final http = Http(
      client: Client(), baseUrl: 'https://rickandmortyapi.com/api', apiKey: '');
  runApp(MultiProvider(
    providers: [
      // conexión a internet
      Provider<ConnectivityRepository>(
        create: (_) => ConnectivityRepositoryImpl(
          Connectivity(),
          InternetChecker(),
        ),
      ),
      Provider<RickAndMortyRepository>(
        create: (_) => RickAndMortyRepositoryImpl(
          RickAndMortyApi(http),
        ),
      ),
    ],
    child: const MyApp(),
  ));
}
