import 'package:authapp/app/ui/global_controllers/session_controller.dart';
import 'package:authapp/app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/router.dart' as router;

import 'package:authapp/app/ui/pages/splash/splash_controller.dart';

// Para escuchar algún cambio
final splashProvider =
    SimpleProvider((_) => SplashController(sessionProvider.read));

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive _responsive = Responsive.of(context);
    return ProviderListener<SplashController>(
      provider: splashProvider,
      // Para que la pantalla sea portrait en smartphones
      onAfterFirstLayout: (_, __) {
        if (_responsive.width < 450) {
          // Bloquear landscape
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
        }
      },
      onChange: (_, controller) {
        final routeName = controller.routeName;
        if (routeName != null) {
          router.pushReplacementNamed(routeName);
        }
      },
      builder: (_, __) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
