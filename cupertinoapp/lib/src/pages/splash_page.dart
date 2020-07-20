import 'package:cupertinoapp/src/pages/home_page.dart';
import 'package:flutter/material.dart';

import 'package:after_layout/after_layout.dart';
import 'package:cupertinoapp/src/pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with AfterLayoutMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((_) {
      /* Navigator.pushReplacementNamed(context, LoginPage.routename); */
      this._checkLogin();
    });
  }

  _checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool wasLogin = prefs.getBool('wasLogin');
    if (wasLogin == null || !wasLogin) {
      Navigator.pushReplacementNamed(context, LoginPage.routename);
    } else {
      Navigator.pushReplacementNamed(context, HomePage.routename);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: CupertinoActivityIndicator(
        radius: 15.0,
      )),
    );
  }
}
