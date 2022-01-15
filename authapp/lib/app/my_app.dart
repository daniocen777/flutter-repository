import 'package:flutter/material.dart';

import 'package:flutter_meedu/router.dart' as router;

import 'package:authapp/app/ui/routes/app_routes.dart';
import 'package:authapp/app/ui/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: router.navigatorKey,
      title: 'Flutter Auth',
      initialRoute: Routes.splash,
      navigatorObservers: [
        // Pendiente de cambios en las rutas (observa las notificaciones)
        router.observer
      ],
      routes: appRoutes,
    );
  }
}
