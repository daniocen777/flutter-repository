import 'package:flutter/material.dart';

import 'presentation/routes/app_routes.dart';
import 'presentation/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Para minimizar teclado en ios
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splash,
        onUnknownRoute: (_) => MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Image.asset('assets/images/error-404.png'),
                  ),
                )),
        routes: appRoutes,
      ),
    );
  }
}


/* 
// Para capturar las url con parámetros (IDs)
        onGenerateRoute: (settings) {
          try {
            // escuchar la navegación
            // Para los querys
            final uri = Uri.parse(settings.name ?? '');
            final path = uri.path;
            if (path == Routes.movie) {
              return null;
            }
            if (path.startsWith(Routes.movie)) {
              final id = int.parse(uri.pathSegments.last);

              return MaterialPageRoute(
                builder: (BuildContext context) => MovieView(movieId: id),
                settings: settings,
              );
            }
            return null;
          } catch (e) {
            return MaterialPageRoute(
              builder: (BuildContext context) => Scaffold(
                body: Center(
                  child: Text(e.toString()),
                ),
              ),
              settings: settings,
            );
          }
        },
 */