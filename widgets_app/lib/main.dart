import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/router/app_router.dart';
import 'config/theme/app_theme.dart';
import 'presentation/providers/theme_provider.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    /* final bool isDarkMode = ref.watch(isDarkModeProvider);
    final int selectedColor = ref.watch(selectedColorProvider); */
    // Hacerlo con el objeto
    final AppTheme appTheme = ref.watch(themeNotifierProvider);

    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      /* theme: AppTheme(selectedColor: selectedColor, isDarkMode: isDarkMode)
          .getTheme(), */
      theme: appTheme.getTheme(),
      title: 'Widgets App',
    );
  }
}
