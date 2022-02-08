import 'package:firebase_auth/firebase_auth.dart';

import 'package:authapp/app/domain/response/reset_password_response.dart';
import 'package:authapp/app/domain/response/sign_in_response.dart';

abstract class AuthenticationRepository {
/* Método para saber si se tiene una sesión activa */
  Future<User?> get user;
  // Cerrar sesión
  Future<void> signOut();
  // logueo
  Future<SignInResponse> signInWithEmailAndPassword(
      String email, String password);

  // Recuperar password
  Future<ResetPasswordResponse> sendResetPasswordLink(String email);
}
