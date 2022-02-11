import 'package:authapp/app/inject_dependencies.dart';
import 'package:authapp/app/my_app.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Creando las instancias
  await injectDependencies();
  runApp(const MyApp());
}
