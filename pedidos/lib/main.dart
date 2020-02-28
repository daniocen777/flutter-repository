import 'package:flutter/material.dart';
//import 'package:pedidos/src/pages/logueo/login_page.dart';
import 'package:pedidos/src/rutas/rutas.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // Probando branch
  @override
  Widget build(BuildContext context) {
    // PADRE PRINCIPAL
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pedidos',
      initialRoute: 'login',
      routes: getApplicationRoutes(),
      /*  onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginPage());
      }, */
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.cyan[400],
          accentColor: Colors.deepOrange[200],
          textTheme: TextTheme(
              headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
              body1: TextStyle(fontSize: 18.0))),
    );
  }
}
