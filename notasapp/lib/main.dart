import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../src/core/constants/index.dart';
import '../src/ui/pages/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: Constants.MAIN_TITLE,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: GoogleFonts.poppins().fontFamily),
        routes: {
          HomePage.HOME_PAGE_ROUTE: (BuildContext context) => HomePage()
        },
        initialRoute: HomePage.HOME_PAGE_ROUTE);
  }
}
