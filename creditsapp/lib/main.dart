import 'package:flutter/material.dart';

import 'package:flutter_meedu/router.dart' as router;

import 'package:creditsapp/app/inject_dependencies.dart';
import 'package:creditsapp/app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Creando las instancias
  await injectDependencies();
  // Transiciones
  router.setDefaultTransition(router.Transition.fadeIn);
  runApp(const MyApp());
}
