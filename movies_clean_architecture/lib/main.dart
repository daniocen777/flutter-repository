import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_clean_architecture/core/app_theme.dart';
import 'package:movies_clean_architecture/features/movies/presentation/blocs/movies/movies_bloc.dart';
import 'package:movies_clean_architecture/features/movies/presentation/pages/movies_page.dart';

import 'injection_container.dart' as di;

void main() async {
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
              create: (_) => di.getIt<MoviesBloc>()
                ..add(const GetPopularMoviesEvent(page: 2)))
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Movies',
            theme: appTheme,
            home: const MoviesPage()));
  }
}
