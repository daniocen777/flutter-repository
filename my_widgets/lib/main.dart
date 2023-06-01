import 'package:flutter/material.dart';
/* import 'package:my_widgets/facebook_ui/facebook_ui.dart'; */
import 'package:my_widgets/routes/app_routes.dart';
import 'package:my_widgets/routes/route.dart';

void main() => runApp(const MyApp());
// https://github.com/darwin-morocho/flutter-desde-cero-2022

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(fontFamily: 'Nunito'),
      routes: appRoutes,
      initialRoute: Routes.splash,
    );
  }
}
