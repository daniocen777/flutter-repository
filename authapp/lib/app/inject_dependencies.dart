/* Inyectar dependencias (crear instancias) */
import 'package:authapp/app/data/repositories_impl/preferences_repository_impl.dart';
import 'package:authapp/app/domain/repositories/preferences_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_meedu/meedu.dart';

import 'package:authapp/app/data/repositories_impl/account_repository_impl.dart';
import 'package:authapp/app/data/repositories_impl/authentication_repository_impl.dart';
import 'package:authapp/app/data/repositories_impl/sign_up_repository_impl.dart';
import 'package:authapp/app/domain/repositories/account_repository.dart';
import 'package:authapp/app/domain/repositories/authentication_repository.dart';
import 'package:authapp/app/domain/repositories/sign_up_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> injectDependencies() async {
  // Para usar SharedPreferences, necesita ser async
  final preferences = await SharedPreferences.getInstance();
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

  /* Para SharedPreference (darkMode) */
  Get.i.lazyPut<PreferencesRepository>(
      () => PreferencesRepositoryImpl(preferences));
}
