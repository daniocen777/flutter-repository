import 'package:amazon_clone/features/auth/screens/login_screen.dart';
import 'package:amazon_clone/features/auth/screens/register_screen.dart';
import 'package:flutter/material.dart';

import 'package:amazon_clone/features/auth/screens/auth_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    AuthScreen.route: (BuildContext context) => const AuthScreen(),
    LoginScreen.route: (BuildContext context) => const LoginScreen(),
    RegisterScreen.route: (BuildContext context) => const RegisterScreen(),
  };
}
