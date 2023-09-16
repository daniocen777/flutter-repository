import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/router/app_router.dart';
import 'config/theme/app_theme.dart';

// Para usar el .env, modificar el main como se muestra
// https://github.com/Klerith/flutter-cinemapedia/tree/fin-seccion-14
Future<void> main() async {
  await dotenv.load(fileName: ".env");
  // Riverpod
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'The Movie DB con riverpod y clean architecture',
      theme: AppTheme().getTheme(),
      routerConfig: appRouter,
    );
  }
}
