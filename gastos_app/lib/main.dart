import 'package:flutter/material.dart';
import 'package:gastos_app/src/pages/add_page.dart';
import 'package:gastos_app/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (BuildContext context) => HomePage(),
        "/add": (BuildContext context) => AddPage()
      },
    );
  }
}
