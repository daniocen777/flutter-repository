import 'package:authapp/app/ui/global_controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

import 'package:flutter_meedu/router.dart' as router;

import 'package:authapp/app/ui/routes/app_routes.dart';
import 'package:authapp/app/ui/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Usar Consumer para escuchar el cambio de tema
    return Consumer(
      builder: (BuildContext context, BuilderRef ref, Widget? child) {
        final themeController = ref.watch(themeProvider); // esuchar los cambios
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: router.navigatorKey,
          title: 'Flutter Auth',
          initialRoute: Routes.splash,
          themeMode: themeController.themeMode,
          darkTheme: ThemeData.dark(),
          theme: ThemeData.light(),
          navigatorObservers: [
            // Pendiente de cambios en las rutas (observa las notificaciones)
            router.observer
          ],
          routes: appRoutes,
        );
      },
    );
  }
}
