import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_clean/features/rick_and_morty/presentation/blocs/character_bloc/character_bloc.dart';

import 'injection_container.dart' as di;

import 'package:rick_morty_clean/core/themes/app_theme.dart';
import 'package:rick_morty_clean/features/rick_and_morty/presentation/routes/app_routes.dart';
import 'package:rick_morty_clean/features/rick_and_morty/presentation/routes/routes.dart';

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = PostHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => di.getIt<CharacterBloc>()
                ..add(const GetAllCharactersPaginatedEvent(page: 1)))
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Rick and Morty',
            theme: appTheme,
            initialRoute: Routes.characters,
            routes: appRoutes));
  }
}
