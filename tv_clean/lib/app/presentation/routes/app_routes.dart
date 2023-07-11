import 'package:flutter/widgets.dart';

import '../modules/home/viewa/home_view.dart';
import '../modules/offline/offline_view.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/splash/views/splash_view.dart';
import 'routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.splash: (context) => const SplashView(),
    Routes.signIn: (context) => const SigInView(),
    Routes.home: (context) => const HomeView(),
    Routes.offline: (context) => const OfflineView()
  };
}
