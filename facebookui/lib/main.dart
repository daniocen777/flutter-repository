import 'package:flutter/material.dart';

import './pages/home_page.dart';
import './config/palette.dart';

/* 47 */

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Facebook App',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: Palette.scaffold),
        home: HomePage());
  }
}
