import 'package:flutter/material.dart';
import './pages/main_page.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import './pages/splash_page.dart';

void main() => runApp(SplashPage(
    onInitializationComplete: () => runApp(ProviderScope(child: MyApp()))));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movies',
        initialRoute: 'home',
        routes: {'home': (BuildContext context) => MainPage()},
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity));
  }
}
