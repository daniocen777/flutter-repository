import 'package:authapp/app/ui/pages/splash/splash_page.dart';
import 'package:authapp/app/ui/routes/routes.dart';
import 'package:flutter/widgets.dart' show Widget, BuildContext;

Map<String, Widget Function(BuildContext)> get appRoutes => {
      Routes.splash: (_) => const SplashPage(),
    };
