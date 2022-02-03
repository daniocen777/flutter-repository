import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Home'),
            const SizedBox(height: 20.0),
            CupertinoButton(
              child: const Text('Cerrar sesión'),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
