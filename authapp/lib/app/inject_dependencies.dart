/* Inyectar dependencias (crear instancias) */
import 'package:authapp/app/data/repositories_impl/authentication_repository_impl.dart';
import 'package:authapp/app/domain/repositories/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_meedu/meedu.dart';

void injectDependencies() {
  /* inject the dependency as a singleton */
  // Crear instancia solo cuando se necesite
  Get.i.lazyPut<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(FirebaseAuth.instance));
}
