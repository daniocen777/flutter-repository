import 'package:flutter/material.dart';
import 'package:mapapp/src/pages/request_permission_page.dart';

import 'package:mapapp/src/pages/splash_page.dart';
import 'package:mapapp/src/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Se necista configurar android y ios para los permisos:
  // https://github.com/Baseflow/flutter-permission-handler/tree/develop/permission_handler/example
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
      routes: {
        SplashPage.route: (BuildContext context) => SplashPage(),
        HomePage.route: (BuildContext context) => HomePage(),
        RequestPersmissionPage.route: (BuildContext context) =>
            RequestPersmissionPage()
      },
    );
  }
}
