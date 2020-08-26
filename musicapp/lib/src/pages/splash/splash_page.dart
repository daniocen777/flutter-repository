import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:after_layout/after_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musicapp/src/libs/auth.dart';
import 'package:musicapp/src/pages/home/home_page.dart';
import 'package:musicapp/src/pages/login/login_page.dart';

class SplashPage extends StatefulWidget {
  static final routeName = 'splash';

  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with AfterLayoutMixin {
  @override
  void afterFirstLayout(BuildContext context) async {
    Auth.instance.user.then((FirebaseUser user) {
      if (user != null) {
        /* Estoy logueado => Ir al home */
        Navigator.pushReplacementNamed(context, HomePage.routeName);
      } else {
        /* Si no lo está, ir al login */
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CupertinoActivityIndicator()),
    );
  }
}
