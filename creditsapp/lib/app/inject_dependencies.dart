import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_meedu/meedu.dart';

import 'package:creditsapp/app/data/repositories_implements/preferences_repository_impl.dart';
import 'package:creditsapp/app/data/repositories_implements/student_repository_impl.dart';
import 'package:creditsapp/app/domain/db/conection.dart';
import 'package:creditsapp/app/domain/repositories/preferences_repository.dart';
import 'package:creditsapp/app/domain/repositories/student_repository.dart';
import 'package:creditsapp/app/data/repositories_implements/authentication_repository_impl.dart';
import 'package:creditsapp/app/domain/repositories/authentication_repository.dart';

Future<void> injectDependencies() async {
  final preferences = await SharedPreferences.getInstance();
  Get.i.lazyPut<PreferencesRepository>(
      () => PreferencesRepositoryImpl(preferences));

  Get.i.lazyPut<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(preferences));

  Get.i.lazyPut<StudentRepository>(() => StudentRepositoryImpl(DB()));
}
