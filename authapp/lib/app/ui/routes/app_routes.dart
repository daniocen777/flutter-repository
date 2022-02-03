import 'package:authapp/app/ui/pages/home/home_page.dart';
import 'package:authapp/app/ui/pages/register/register_page.dart';
import 'package:flutter/material.dart';

import 'package:authapp/app/ui/pages/login/login_page.dart';
import 'package:authapp/app/ui/pages/splash/splash_page.dart';
import 'package:authapp/app/ui/routes/routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes => {
      Routes.splash: (_) => const SplashPage(),
      Routes.login: (_) => const LoginPage(),
      Routes.register: (_) => const RegisterPage(),
      Routes.home: (_) => const HomePage()
    };
