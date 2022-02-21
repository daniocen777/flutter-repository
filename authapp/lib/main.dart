import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_meedu/router.dart' as router;

import 'package:authapp/app/inject_dependencies.dart';
import 'package:authapp/app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Creando las instancias
  await injectDependencies();
  // Transiciones
  router.setDefaultTransition(router.Transition.fadeIn);
  runApp(const MyApp());
}
