import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/routes/app_router.dart';
import 'core/theme/theme.dart';

// Para crear el splash, ejecutar el comando:
// flutter pub run flutter_native_splash:create --path=splash.yaml

Future<void> main() async {
  await dotenv.load(fileName: ".env"); // usar environment
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        title: 'Marvel API',
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        routerConfig: appRouter);
  }
}
