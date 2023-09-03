import 'package:flutter/material.dart';

import 'config/theme/app_theme.dart';
import 'presentation/screens/buttons/buttons_screen.dart';
import 'presentation/screens/cards/cards_screen.dart';
import 'presentation/screens/home/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 0).getTheme(),
      title: 'Widgets App',
      home: const HomeScreen(),
      routes: {
        '/buttons': (_) => const ButtonsScreen(),
        '/cards': (_) => const CardsScreen(),
      },
    );
  }
}
