import 'package:flick_app/pages/main_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flick_app/pages/splash_page.dart';

void main() {
  runApp(
    SplashPage(
        onInitializationComplete: () =>
            runApp(const ProviderScope(child: MyApp()))),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Movies App",
        initialRoute: "home",
        debugShowCheckedModeBanner: false,
        routes: {
          "home": (BuildContext context) => MainPage(),
        },
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity));
  }
}
