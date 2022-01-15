import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepository {
/* Método para saber si se tiene una sesión activa */
  Future<User?> get user;
}