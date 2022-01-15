import 'package:authapp/app/ui/routes/app_routes.dart';
import 'package:authapp/app/ui/routes/routes.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      initialRoute: Routes.splash,
      routes: appRoutes,
    );
  }
}
