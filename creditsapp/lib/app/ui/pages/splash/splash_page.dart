import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/router.dart' as router;

import 'package:creditsapp/app/ui/pages/splash/splash_controller.dart';

final splashProvider = SimpleProvider((_) => SplashController());

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<SplashController>(
      provider: splashProvider,
      onAfterFirstLayout: (_, __) {
        if (!context.isTablet) {
          // Bloquear landscape
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
        }
      },
      onChange: (_, controller) {
        print('EMTRA AL CHANGE');
        final routeName = controller.routeName;
        if (routeName != null) {
          router.pushReplacementNamed(routeName);
        }
      },
      builder: (_, __) {
        print('ENTRA AL PROGRESS');
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
