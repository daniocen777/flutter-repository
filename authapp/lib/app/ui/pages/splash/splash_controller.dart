import 'package:authapp/app/ui/global_controllers/session_controller.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:authapp/app/domain/repositories/authentication_repository.dart';
import 'package:authapp/app/ui/routes/routes.dart';

/* extender de SimpleNotifier para notificar los cambios */
class SplashController extends SimpleNotifier {
  // Estado de la sesión
  final SessionController _sessionController;
  final _authRepository = Get.i.find<AuthenticationRepository>();

  String? _routeName;
  String? get routeName => _routeName;

  SplashController(this._sessionController) {
    _init();
  }

  void _init() async {
    final User? user = await _authRepository.user;
    if (user != null) {
      _routeName = Routes.home;
      // Guardando los datos del usuarioo en sessionController
      _sessionController.setUser(user);
    } else {
      _routeName = Routes.login;
    }
    // Notificar el cambio de ruta
    notify();
  }

  /* Liberar recursos => inecesario, ya que se autodestruye al cambiar de página */
/*   @override
  void dispose() {
    super.dispose();
  } */
}
