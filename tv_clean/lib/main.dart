import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'app/data/repositories_impl/authentication_repository_impl.dart';
import 'app/data/repositories_impl/connectivity_repository_impl.dart';
import 'app/data/services/remote/internet_checker.dart';
import 'app/domain/repositories/authentication_repository.dart';
import 'app/domain/repositories/connectivity_repository.dart';
import 'app/my_app.dart';

void main() {
  runApp(Injector(
      connectivityRepository:
          ConnectivityRepositoryImpl(Connectivity(), InternetChecker()),
      authenticationRepository: AuthenticationRepositoryImpl(),
      child: const MyApp()));
}

// Inyectar los repositories
class Injector extends InheritedWidget {
  const Injector(
      {super.key,
      required super.child,
      required this.connectivityRepository,
      required this.authenticationRepository});

  final ConnectivityRepository connectivityRepository;
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
}
