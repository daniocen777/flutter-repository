import 'package:flutter/widgets.dart';

import '../modules/home/views/home_view.dart';
import '../modules/splash/views/splash_view.dart';
import 'routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.splash: (context) => const SplashView(),
    Routes.home: (context) => const HomeView(),
  };
}
