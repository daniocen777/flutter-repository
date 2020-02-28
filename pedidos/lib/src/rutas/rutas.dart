import 'package:flutter/material.dart';
import 'package:pedidos/src/pages/logueo/login_page.dart';
import 'package:pedidos/src/pages/logueo/register_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    "login": (BuildContext context) => LoginPage(),
    "register": (BuildContext context) => RegisterPage(),
  };
}
