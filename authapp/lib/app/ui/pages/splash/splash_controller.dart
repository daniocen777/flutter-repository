import 'package:flutter_meedu/meedu.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:authapp/app/domain/repositories/authentication_repository.dart';
import 'package:authapp/app/ui/routes/routes.dart';

/* extender de SimpleNotifier para notificar los cambios */
class SplashController extends SimpleNotifier {
  final _authRepository = Get.i.find<AuthenticationRepository>();

  String? _routeName;
  String? get routeName => _routeName;

  SplashController() {
    _init();
  }

  void _init() async {
    final User? user = await _authRepository.user;
    _routeName = user != null ? Routes.home : Routes.login;
    // Notificar el cambio de ruta
    notify();
  }

  /* Liberar recursos */
/*   @override
  void dispose() {
    super.dispose();
  } */
}
