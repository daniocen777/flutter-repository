import 'package:authapp/app/domain/response/sign_in_response.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepository {
/* Método para saber si se tiene una sesión activa */
  Future<User?> get user;
  // Cerrar sesión
  Future<void> signOut();
  // logueo
  Future<SignInResponse> signInWithEmailAndPassword(
      String email, String password);
}

