import 'package:flutter/material.dart';
import 'package:musicapp/src/pages/login/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'sans'),
        home: LoginPage());
  }
}
