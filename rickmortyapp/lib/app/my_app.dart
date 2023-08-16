import 'package:flutter/material.dart';
import 'package:rickmortyapp/app/presentation/routes/app_routes.dart';
import 'package:rickmortyapp/app/presentation/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
