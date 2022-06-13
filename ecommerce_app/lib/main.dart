import 'package:ecommerce_app/consts.dart';
import 'package:ecommerce_app/views/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme:
            ThemeData.dark().copyWith(scaffoldBackgroundColor: backgroundColor),
        home: const LoginScreen());
  }
}
