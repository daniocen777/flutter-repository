import 'package:flutter/material.dart';

import 'core/routes/app_router.dart';
import 'core/theme/main_theme.dart';

void main() => runApp(const MyApp());

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
