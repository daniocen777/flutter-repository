import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../layout.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dash',
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)
                .apply(bodyColor: Colors.black87),
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            }),
            primaryColor: Colors.blue),
        home: SiteLayout());
  }
}
