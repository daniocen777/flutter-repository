import 'package:flutter/material.dart';
import 'package:many_pages/constants/colors_const.dart';
import 'package:many_pages/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // Probando branch
  @override
  Widget build(BuildContext context) {
    // PADRE PRINCIPAL
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: [
        const Locale('en'), // English
        const Locale('es'),
      ],
      title: 'Many App',
      initialRoute: 'loginOne',
      routes: getApplicationRoutes(),
      theme: ThemeData(primaryColor: primaryColor, accentColor: secondColor),
      /* onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginPage());
      }, */
    );
  }
}
