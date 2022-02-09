/* Inyectar dependencias (crear instancias) */
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_meedu/meedu.dart';

import 'package:authapp/app/data/repositories_impl/account_repository_impl.dart';
import 'package:authapp/app/data/repositories_impl/authentication_repository_impl.dart';
import 'package:authapp/app/data/repositories_impl/sign_up_repository_impl.dart';
import 'package:authapp/app/domain/repositories/account_repository.dart';
import 'package:authapp/app/domain/repositories/authentication_repository.dart';
import 'package:authapp/app/domain/repositories/sign_up_repository.dart';

void injectDependencies() {
  /* inject the dependency as a singleton */
  /* Para la sesión */
  // Crear instancia solo cuando se necesite
  Get.i.lazyPut<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(FirebaseAuth.instance));

  /* Para el regstro de nuevo usuario firebase (email, password) */
  // Crear instancia solo cuando se necesite
  Get.i.lazyPut<SignUpRepository>(
      () => SignUpRepositoryImpl(FirebaseAuth.instance));

  /* Para la cuenta (actualizar nombre de usuario) */
  Get.i.lazyPut<AccountRepository>(
      () => AccountRepositoryImpl(FirebaseAuth.instance));
}
