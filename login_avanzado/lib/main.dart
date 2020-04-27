import 'package:flutter/material.dart';
import 'package:login_avanzado/src/pages/login/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login avanzado',
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'sans'),
        home: LoginPage());
  }
}
