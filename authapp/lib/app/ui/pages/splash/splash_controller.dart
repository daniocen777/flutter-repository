import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_meedu/meedu.dart';

import 'package:authapp/app/domain/repositories/authentication_repository.dart';

class SplashController {
  final _authRepository = Get.i.find<AuthenticationRepository>();

  SplashController() {
    _init();
  }

  void _init() async {
    final User? user = await _authRepository.user;
    if (user != null) {
      // Se tiene sesión activa
      print("sesión activa");
    } else {
      print("sesión inactiva");
    }
  }
}
