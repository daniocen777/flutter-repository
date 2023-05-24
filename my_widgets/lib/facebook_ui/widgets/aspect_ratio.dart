import 'package:flutter/material.dart';

class MyAspectRatio extends StatelessWidget {
  const MyAspectRatio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.network(
              'https://i.pinimg.com/originals/df/af/1d/dfaf1dad91482691574a3276922b36c9.png'),
        ),
      ),
    );
  }
}
