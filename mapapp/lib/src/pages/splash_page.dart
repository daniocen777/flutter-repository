/* Si permiso de acceder a la ubicación del dispositivo */
import 'package:flutter/material.dart';

import 'package:after_layout/after_layout.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:mapapp/src/pages/home_page.dart';
import 'package:mapapp/src/pages/request_permission_page.dart';

class SplashPage extends StatefulWidget {
  static final route = 'splash';
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with AfterLayoutMixin {
  // Se ejecutar una sola vez cuando el widget ha sido renderizado
  @override
  void afterFirstLayout(BuildContext context) {
    this._check();
  }

  _check() async {
    final bool hasAccess = await Permission.locationWhenInUse.isGranted;
    if (hasAccess) {
      Navigator.pushReplacementNamed(context, HomePage.route);
    } else {
      Navigator.pushReplacementNamed(context, RequestPersmissionPage.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
