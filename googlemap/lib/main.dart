import 'package:flutter/material.dart';
import 'package:googlemap/src/pages/login/register_page.dart';

import 'src/pages/login/login_page.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /* Evitar la rotación del dispositivo */
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Map',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
      routes: {
        LoginPage.route: (BuildContext context) => LoginPage(),
        RegisterPage.route: (BuildContext context) => RegisterPage(),
      },
    );
  }
}
