import 'package:flutter/material.dart';
import 'package:musicapp/src/pages/home/home_page.dart';
import 'package:musicapp/src/pages/login/forgot-password_page.dart';
import 'package:musicapp/src/pages/login/login_page.dart';
import 'package:musicapp/src/pages/login/register_page.dart';
import 'package:musicapp/src/pages/splash/splash_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'sans'),
        home: SplashPage(),
        routes: {
          SplashPage.routeName: (BuildContext context) => SplashPage(),
          LoginPage.routeName: (BuildContext context) => LoginPage(),
          RegisterPage.routeName: (BuildContext context) => RegisterPage(),
          ForgotPasswordPage.routeName: (BuildContext context) =>
              ForgotPasswordPage(),
          HomePage.routeName: (BuildContext context) => HomePage()
        });
  }
}
