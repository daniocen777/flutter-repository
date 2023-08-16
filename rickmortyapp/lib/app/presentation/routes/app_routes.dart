import 'package:flutter/widgets.dart';
import 'package:rickmortyapp/app/presentation/modules/home/views/home_view.dart';
import 'package:rickmortyapp/app/presentation/modules/splash/views/splash_view.dart';
import 'package:rickmortyapp/app/presentation/routes/routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.splash: (context) => const SplashView(),
    Routes.home: (context) => const HomeView(),
  };
}
