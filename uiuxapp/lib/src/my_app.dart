import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './utils/colors.dart';
import './utils/font_style.dart';

import 'routes/pages.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(
          primaryColor: primaryColor,
          accentColor: accentColor,
          textTheme: FontStyle.textTheme,
          /* Para los botones cupertino */
          cupertinoOverrideTheme: CupertinoThemeData(
            primaryColor: primaryColor,
            textTheme: CupertinoTextThemeData(
              textStyle: FontStyle.normal
            )
          )
          ),
      initialRoute: Pages.INITIAL,
      routes: Pages.routes,
    );
  }
}
