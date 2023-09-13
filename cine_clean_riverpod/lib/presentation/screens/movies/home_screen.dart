import 'package:flutter/material.dart';

import '../../../config/constants/environment.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const name = 'home-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(Environment.movieDBKey),
      ),
    );
  }
}
