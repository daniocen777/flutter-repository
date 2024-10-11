import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/routes/app_router.dart';
import 'core/theme/main_theme.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env"); // usar environment
  runApp(const MyApp());
}

ThemeData theme(ColorScheme colorScheme) => ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.background,
      canvasColor: colorScheme.surface,
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Marvel API',
        theme: theme(MainTheme.lightScheme()),
        routerConfig: appRouter);
  }
}
