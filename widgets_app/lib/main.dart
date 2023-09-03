import 'package:flutter/material.dart';

import 'config/theme/app_theme.dart';
import 'presentation/screens/home/home_screen.dart';

void main() => runApp(const MyApp());

//v https://futbollibretv.me/espn2.php##

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme(selectedColor: 0).getTheme(),
        title: 'Widgets App',
        home: const HomeScreen());
  }
}
