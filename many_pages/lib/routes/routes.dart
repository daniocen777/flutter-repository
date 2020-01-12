import 'package:flutter/material.dart';
import 'package:many_pages/pages/liquid_page.dart';
import 'package:many_pages/pages/login_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => LiquidPage(),
    'loginOne': (BuildContext context) => LoginPage()
  };
}
