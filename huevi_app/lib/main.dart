import 'package:flutter/material.dart';
import 'package:huevi_app/src/pages/home/home_page.dart';
import 'package:huevi_app/src/pages/login/login_page.dart';
import 'package:huevi_app/src/pages/videos/videos_page.dart';
import 'package:huevi_app/src/utils/app_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /* AIzaSyDsS9jK67b3_brCVpOxPP50UHB1cbAS14o */
      /* UCba1vMvOHWlMddLARS382Zw */
      debugShowCheckedModeBanner: false,
      title: 'HueviApp',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        accentColor: AppColors.gray,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
      routes: {
        LoginPage.route: (BuildContext context) => LoginPage(),
        HomePage.route: (BuildContext context) => HomePage(),
        VideosPage.route: (BuildContext context) => VideosPage()
      },
    );
  }
}
