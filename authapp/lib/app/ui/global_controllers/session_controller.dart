/* Estados globales para la app */

import 'package:authapp/app/domain/repositories/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_meedu/meedu.dart';

class SessionController extends SimpleNotifier {
  User? _user;
  User? get user => _user;
  // Ya se tiene metodo signOut
  final _auth = Get.i.find<AuthenticationRepository>();

  /* dispose => EL controlador se autodestruye al ir a otra página != al controlador.
  Para persistir esl estado (global) autoDispose: false */
  /* @override
  void dispose() {
    super.dispose();
  } */

  void setUser(User user) {
    _user = user;
    notify();
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _user = null;
  }
}

/* Estado global "autoDispose: false" para no atodestruir el cotrolador */
final sessionProvider =
    SimpleProvider((_) => SessionController(), autoDispose: false);
