import 'package:flutter/material.dart';

import '../pages/forgot_password.dart';
import '../pages/login_page.dart';
import '../pages/welcome_page.dart';

final routes = <String, WidgetBuilder>{
  'welcome': (BuildContext context) => WelcomePage(),
  'login': (BuildContext context) => LoginPage(),
  'forgot_password': (BuildContext context) => ForgotPassword(),
};
