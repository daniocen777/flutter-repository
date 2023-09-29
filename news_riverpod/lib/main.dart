import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/routers/app_router.dart';
import 'core/themes/app_theme.dart';

void main() {
  return runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: AppTheme().getTheme(),
      routerConfig: appRouter,
    );
  }
}
