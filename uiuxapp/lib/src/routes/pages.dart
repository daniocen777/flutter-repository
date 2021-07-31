import 'package:flutter/widgets.dart';

import '../pages/login/login_page.dart';
import '../pages/resgister/register_page.dart';
import '../pages/welcome/welcome_page.dart';
import '../pages/onboard/onboard_page.dart';
import '../routes/routes.dart';

abstract class Pages {
  static const String INITIAL = Routes.ONBOARD;
  static final Map<String, Widget Function(BuildContext)> routes = {
    Routes.ONBOARD: (_) => OnboardPage(),
    Routes.WELCOME: (_) => WelcomePage(),
    Routes.LOGIN: (_) => LoginPage(),
    Routes.REGISTER: (_) => RegisterPage(),
  };
}
